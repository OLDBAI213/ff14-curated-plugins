# 插件仓库统计台账（REPOS.md）

> 目的：老白合集（pluginmaster.json）里每个插件的**上游仓库、分发方式、维护状态**一站式统计。配 `scripts/check-updates.ps1` 巡检工具，上游有更新/有问题第一时间知道。
> 最近巡检：2026-08-28（见 `upstream-status.json`）

## 一、仓库总表（15 个插件）

| 插件 | 上游仓库 | 分发方式 | 清单版本 | 上游状态（08-28） |
|---|---|---|---|---|
| Daily Routines | [Dalamud-DailyRoutines/DailyRoutines](https://github.com/Dalamud-DailyRoutines/DailyRoutines) | 自有分发源 PluginDistD17 | 2.1.7.0 | ✅ 最新 |
| AutoHook | [PunishXIV/AutoHook](https://github.com/PunishXIV/AutoHook) | puni.sh API（无 GitHub release） | 6.0.0.95 | ⚠️ 走源分发，巡检看源仓库 |
| ICE 宇宙探索助手 | [OLDBAI213/OLDBAI](https://github.com/OLDBAI213/OLDBAI) | **老白自维护** GitHub release | 0.0.78.7000 | ✅ 最新（自维护，最后推送 06-20） |
| vnavmesh（CN） | [AtmoOmen/ffxiv_navmesh-cn](https://github.com/AtmoOmen/ffxiv_navmesh-cn) | GitHub release | 0.8.0.0 | ✅ 最新 |
| GatherBuddyReborn | [AtmoOmen/GatherBuddyReborn](https://github.com/AtmoOmen/GatherBuddyReborn) | GitHub release | 7.5.0.4 | ✅ 最新（⚠️ 本机加载失败待查） |
| Artisan | [PunishXIV/Artisan](https://github.com/PunishXIV/Artisan) | puni.sh API（无 GitHub release） | 4.0.5.18 | ⚠️ 走源分发 |
| Rotation Solver Reborn | [FFXIV-CombatReborn/RotationSolverReborn](https://github.com/FFXIV-CombatReborn/RotationSolverReborn) | GitHub release | 7.5.5.39 | ✅ 最新 |
| BossMod Reborn | [FFXIV-CombatReborn/BossmodReborn](https://github.com/FFXIV-CombatReborn/BossmodReborn) | GitHub release + CombatRebornRepo 源 | **7.5.5.61**（08-28 已更新）| ✅ 已跟进上游 08-27 新版 |
| DCTravelerX | [Dalamud-DailyRoutines/DCTraveler](https://github.com/Dalamud-DailyRoutines/DCTraveler) | GitHub release | 0.3.5.0 | ✅ 最新 |
| MacroMate | [grittyfrog/MacroMate](https://github.com/grittyfrog/MacroMate) | GitHub release（清单 27.4 > 上游 tag 25.6，清单更新） | 1.0.27.4 | ✅ 最新 |
| NyaDraw | 经 [NiGuangOwO/DalamudPlugins](https://github.com/NiGuangOwO/DalamudPlugins) 源分发（汉化库 [NyaDraw.Localizations](https://github.com/NiGuangOwO/NyaDraw.Localizations)）| 源仓库直链 | 1.15.1.2 | ⚠️ 走源分发 |
| Teamcraft List Maker | [Aida-Enna/TeamcraftListMaker](https://github.com/Aida-Enna/TeamcraftListMaker) | PluginDistD17 源分发 | 1.0.1.2 | ⚠️ 走源分发 |
| Workshop Optimizer | [belzaru17/WorkshopOptimizerPlugin](https://github.com/belzaru17/WorkshopOptimizerPlugin) | **老白汉化 release**（ff14-dalamud-plugin-zh） | 0.3.2.0 | ✅ 最新 |
| Lifestream | [NightmareXIV/Lifestream](https://github.com/NightmareXIV/Lifestream) | NiGuangOwO 源直链（上游 release 略旧于清单） | 2.5.4.17 | ✅ 最新 |
| Wrath Combo | [PunishXIV/WrathCombo](https://github.com/PunishXIV/WrathCombo) | GitHub release | 1.0.4.21 | ✅ 最新 |

## 二、分发方式说明（为什么有的查不到 release）

- **GitHub release 型**（10 个）：上游直接发 release，巡检脚本直接对比版本号
- **puni.sh 型**（AutoHook、Artisan、WrathCombo 系）：作者用 puni.sh 平台分发，GitHub 没有 release——巡检看**分发源仓库**（LiangYuxuan/dalamud-plugin-cn-fetcher、PluginDistD17）的推送动态
- **源直链型**（NyaDraw、TeamcraftListMaker、Lifestream 的清单链接）：插件源仓库里放 latest.zip——巡检看源仓库
- **自维护型**（ICE、Workshop Optimizer 汉化）：老白自己的仓库/release，自己发版

## 三、巡检与更新操作（大白话）

**查更新**（想查就查，一分钟）：
```powershell
pwsh -File scripts/check-updates.ps1 -RepoDir <本仓库目录>
```
输出三态：`OK 最新 / !! 有更新 / ?? 走源分发`，并刷新 upstream-status.json 快照。

**更新某个插件条目**（巡检报"有更新"后）：
```powershell
node scripts/update-entry.js BossModReborn combatreborn
```
从分发源拉最新条目（新版本+新下载链接）替换清单里的旧条目，然后 git 提交推送。

**节奏建议**：平时不用管；游戏版本更新日、或游戏里插件集体抽风时跑一次巡检。

## 四、踩坑记录

- 2026-08-28：GatherBuddyReborn 本机 LoadError（版本与上游一致，疑似 2026.08.05 游戏版本更新后偏移失效，等 AtmoOmen 适配或重装）
- 2026-08-28：BossModReborn 上游发 7.5.5.61（8-27），已用 update-entry 跟进
- MacroMate 清单版本（1.0.27.4）高于上游最新 tag（v1.0.25.6）：清单条目来自 CN 拉取源（可能含未打 tag 的构建），不是错误
