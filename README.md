# FF14 老白精选插件库（Dalamud 第三方插件源）

> 老白（OLDBAI213）日常在用的 FF14 插件精选合集，整合成一份 Dalamud 插件清单。
> 一条链接加进启动器，就能一键装齐这套"自动化全家桶"。

## 怎么用（添加到启动器）

1. 打开 XIVLauncherCN（Soil）→ 插件设置 → 第三方插件源（Dev 下也可）
2. 添加这个地址：

```
https://raw.githubusercontent.com/OLDBAI213/ff14-curated-plugins/main/pluginmaster.json
```

3. 打开插件安装器，搜索下表插件名安装即可。

## 收录插件（15 个）——汉化状态 2026-08-28 全标注

> 🀄=汉化版（清单条目即中文）｜🌐=自带中文（插件内设置切换）｜❌=暂无汉化

### 🤖 自动化核心（老白的口味：能自动的绝不手动）

| 汉化 | 插件 | 干什么 | 出处 |
|---|---|---|---|
| 🀄 | Daily Routines 日常自动化 | 几十个日常小自动化合集（AtmoOmen 汉化）| [Dalamud-DailyRoutines](https://github.com/Dalamud-DailyRoutines/DailyRoutines) |
| 🌐 | AutoHook 自动钓鱼 | 钓鱼全自动（**插件自带中文**：内置 zh.resx，游戏中文客户端自动显示中文，无需换包）| [PunishXIV/AutoHook](https://github.com/PunishXIV/AutoHook) |
| 🀄 | 宇宙探索助手 ICE | 宇宙探索制作/采集/任务辅助（**老白自维护汉化版**）| [OLDBAI213/OLDBAI](https://github.com/OLDBAI213/OLDBAI) |
| 🀄 | vnavmesh 自动寻路 | 自动走位底座（其他自动化插件的"腿"，AtmoOmen 国服版）| [AtmoOmen/ffxiv_navmesh-cn](https://github.com/AtmoOmen/ffxiv_navmesh-cn) |
| 🀄 | GatherBuddyReborn 自动采集 | 采集全自动（AtmoOmen 汉化；ⓘ 游戏版本更新后可能要等适配）| [AtmoOmen/GatherBuddyReborn](https://github.com/AtmoOmen/GatherBuddyReborn) |
| 🀄 | Artisan 自动制作 | 制作全自动（**QiongHHHZZZ 汉化**，与官方同版）| [QiongHHHZZZ/Artisan](https://github.com/QiongHHHZZZ/Artisan) |
| 🌐 | Rotation Solver Reborn 自动循环 | 战斗循环自动打（**自带中文**，游戏内语言设置切换）| [FFXIV-CombatReborn/RotationSolverReborn](https://github.com/FFXIV-CombatReborn/RotationSolverReborn) |
| 🀄 | BossMod Reborn 自动躲机制 | 团本机制自动躲（**NiGuangOwO 汉化 7.5.5.60**，滞后官方 7.5.5.61 一个小版本，官方更新后等汉化跟进）| [NiGuangOwO/DalamudPlugins](https://github.com/NiGuangOwO/DalamudPlugins) |
| 🀄 | DCTravelerX 跨大区 | 跨大区旅行（AtmoOmen 系汉化）| [Dalamud-DailyRoutines/DCTraveler](https://github.com/Dalamud-DailyRoutines/DCTraveler) |

### 🧰 效率/辅助

| 汉化 | 插件 | 干什么 | 出处 |
|---|---|---|---|
| 🟡 | MacroMate 宏管理 | 高级宏管理器（启动器里显示中文名；**界面本身英文**——实测 dll 与官方字节级相同，全网无界面汉化版）| [老白/ff14-dalamud-plugin-zh](https://github.com/OLDBAI213/ff14-dalamud-plugin-zh) |
| 🀄 | NyaDraw 画图 | 游戏内画图/标注（霓虹大中文原生）| [NiGuangOwO](https://github.com/NiGuangOwO/DalamudPlugins) |
| 🟡 | Teamcraft List Maker | 生成 Teamcraft 制作清单（启动器里显示中文名；**界面本身英文**，全网无界面汉化版）| [老白/ff14-dalamud-plugin-zh](https://github.com/OLDBAI213/ff14-dalamud-plugin-zh) |
| 🟡 | Workshop Optimizer 工坊优化 | 空岛工坊排程优化（启动器里显示中文名；**界面本身英文**，全网无界面汉化版）| [老白/ff14-dalamud-plugin-zh](https://github.com/OLDBAI213/ff14-dalamud-plugin-zh) |

### 📦 备选（收录但默认可以不装）

| 汉化 | 插件 | 干什么 | 出处 |
|---|---|---|---|
| 🀄 | Lifestream 快速传送 | 传送门快速移动（NiGuangOwO 汉化；老白用 DCTravelerX 了）| [NightmareXIV/Lifestream](https://github.com/NightmareXIV/Lifestream) |
| 🌐 | Wrath Combo 连击合一 | 技能连击合一（**插件自带中文**：内置 zh-Hans.resx 全套职位汉化；老白用 RS 了，二选一）| [PunishXIV/WrathCombo](https://github.com/PunishXIV/WrathCombo) |

**汉化统计（2026-08-28 dll 级实测修订）：✅ 界面真中文 10 个（AutoHook/WrathCombo/NyaDraw/DailyRoutines/ICE/BossModReborn/GatherBuddyReborn/Lifestream/Artisan(大部分)/RS(少量)）+ 🟡 仅清单中文名、界面英文 4 个（MacroMate/TeamcraftListMaker/WorkshopOptimizer/vnavmesh国际版）**。重要教训：老白 7 月汉化包=官方 dll+中文元数据（清单显示中文，界面未动），实测哈希相同。

## 说明

- 本库只收录清单（pluginmaster.json），插件本体从各官方源下载，**版本跟随上游**
- 汉化版插件（ICE、Workshop Optimizer）来自老白自己的 release
- 全部插件 API Level 15（国服 Dalamud 26-08-27+）
- ⚠️ 免责：使用第三方插件可能违反游戏服务条款，风险自担；本清单仅供个人学习记录

---
维护：小白（DSH）代老白整理 · 2026-08-28 · 数据来源=本机已装插件实测


