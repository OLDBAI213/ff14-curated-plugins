#!/usr/bin/env node
// FF14 精选插件库·条目更新工具
// 用法: node update-entry.js <InternalName> [<分发源pluginmaster.json的URL或简称>]
// 作用: 从指定分发源拉取该插件最新条目（含新版本下载链接），替换本库 pluginmaster.json 里的旧条目。
//       不带源参数时，默认按 scripts/sources.json 里登记的分发源逐个尝试。
// 依赖: node 18+（自带 fetch）

const fs = require('fs');
const path = require('path');

const repoDir = path.resolve(__dirname, '..');
const masterPath = path.join(repoDir, 'pluginmaster.json');
const [,, targetName, sourceArg] = process.argv;

if (!targetName) {
  console.error('用法: node update-entry.js <InternalName> [<源URL>]');
  process.exit(2);
}

// 已知分发源（来源=启动器配置与生态调研，2026-08-28）
const KNOWN_SOURCES = [
  'https://raw.githubusercontent.com/Dalamud-DailyRoutines/PluginDistD17/main/pluginmaster.json',
  'https://raw.githubusercontent.com/AtmoOmen/DalamudPlugins/main/pluginmaster.json',
  'https://raw.githubusercontent.com/NiGuangOwO/DalamudPlugins/main/pluginmaster.json',
  'https://raw.githubusercontent.com/extrant/DalamudPlugins/main/pluginmaster.json',
  'https://raw.githubusercontent.com/LiangYuxuan/dalamud-plugin-cn-fetcher/master/pluginmaster.json',
  'https://raw.githubusercontent.com/FFXIV-CombatReborn/CombatRebornRepo/main/pluginmaster.json',
];

const SHORT_NAMES = {
  dailyroutines: 0, atmoomen: 1, niguangowo: 2, extrant: 3,
  cnfetcher: 4, combatreborn: 5,
};

async function fetchJson(url) {
  const res = await fetch(url, { headers: { 'User-Agent': 'ff14-curated-plugins' } });
  if (!res.ok) throw new Error(`HTTP ${res.status} for ${url}`);
  return res.json();
}

async function main() {
  const master = JSON.parse(fs.readFileSync(masterPath, 'utf8'));
  const index = master.findIndex((p) => p.InternalName === targetName);
  if (index < 0) {
    console.error(`清单里没有 ${targetName}，可收录的插件: ${master.map((p) => p.InternalName).join(', ')}`);
    process.exit(1);
  }
  const old = master[index];

  let sourceUrls;
  if (sourceArg) {
    const resolved = SHORT_NAMES[sourceArg.toLowerCase()] !== undefined
      ? KNOWN_SOURCES[SHORT_NAMES[sourceArg.toLowerCase()]]
      : sourceArg;
    sourceUrls = [resolved];
  } else {
    sourceUrls = KNOWN_SOURCES;
  }

  let fresh = null;
  let usedSource = null;
  for (const url of sourceUrls) {
    try {
      const list = await fetchJson(url);
      const found = Array.isArray(list) ? list.find((p) => p.InternalName === targetName) : null;
      if (found && found.DownloadLinkInstall) { fresh = found; usedSource = url; break; }
    } catch (err) {
      console.error(`跳过源（不可达）: ${url} → ${err.message}`);
    }
  }

  if (!fresh) {
    console.error(`所有分发源里都找不到 ${targetName} 的可用条目（需要下载链接）。`);
    process.exit(1);
  }

  const verChanged = old.AssemblyVersion !== fresh.AssemblyVersion;
  master[index] = fresh;
  fs.writeFileSync(masterPath, JSON.stringify(master, null, 2) + '\n', 'utf8');

  console.log(`✅ ${targetName} 条目已更新（来源: ${usedSource}）`);
  console.log(`   版本: ${old.AssemblyVersion} → ${fresh.AssemblyVersion}${verChanged ? '' : '（版本号未变，刷新了下载链接等字段）'}`);
  console.log(`   下载: ${fresh.DownloadLinkInstall}`);
  if (verChanged) {
    console.log('   下一步: git add pluginmaster.json && git commit && git push，然后启动器里刷新插件源即可看到新版本。');
  }
}

main().catch((err) => { console.error(err.message); process.exit(1); });
