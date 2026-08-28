# FF14 精选插件库·上游更新巡检
# 用法: pwsh -File check-updates.ps1 [-RepoDir <仓库目录>]
# 作用: 读 pluginmaster.json 的 15 个插件，逐个查上游仓库最新 release，
#       与清单版本对比，输出「最新 / 有更新 / 查不到」三态表格，并生成 upstream-status.json。
# 依赖: gh CLI（已登录）

param(
    [string]$RepoDir = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
$masterPath = Join-Path $RepoDir 'pluginmaster.json'
if (-not (Test-Path $masterPath)) { throw "找不到 $masterPath" }

$plugins = Get-Content $masterPath -Raw | ConvertFrom-Json
$results = @()

function Get-LatestVersion([string]$repo) {
    try {
        $rel = gh api "repos/$repo/releases/latest" --jq '{tag: .tag_name, date: .published_at}' 2>$null | ConvertFrom-Json
        if ($rel -and $rel.tag) { return [pscustomobject]@{ tag = $rel.tag; date = $rel.date; ok = $true } }
    } catch {}
    return [pscustomobject]@{ tag = $null; date = $null; ok = $false }
}

function Normalize-Version([string]$text) {
    if (-not $text) { return $null }
    $m = [regex]::Match($text, '(\d+(\.\d+){1,3})')
    if ($m.Success) { return $m.Groups[1].Value }
    return $null
}

function Version-IsNewer([string]$current, [string]$upstream) {
    if (-not $current -or -not $upstream) { return $false }
    $a = $current.Split('.') | ForEach-Object { [int]$_ }
    $b = $upstream.Split('.') | ForEach-Object { [int]$_ }
    $len = [Math]::Max($a.Count, $b.Count)
    for ($i = 0; $i -lt $len; $i++) {
        $x = if ($i -lt $a.Count) { $a[$i] } else { 0 }
        $y = if ($i -lt $b.Count) { $b[$i] } else { 0 }
        if ($y -gt $x) { return $true }
        if ($y -lt $x) { return $false }
    }
    return $false
}

foreach ($p in $plugins) {
    $repo = $p.RepoUrl -replace 'https://github\.com/', '' -replace '\.git$', '' -replace '/$', ''
    $latest = Get-LatestVersion $repo
    $listed = Normalize-Version $p.AssemblyVersion
    $upstream = Normalize-Version $latest.tag

    $status = '未知'
    if ($latest.ok -and $upstream) {
        if (Version-IsNewer $listed $upstream) { $status = '有更新' }
        else { $status = '最新' }
    } elseif ($repo -match 'OLDBAI213/OLDBAI') {
        # 自维护仓库：直接读仓库最后推送时间
        $pushed = gh api "repos/$repo" --jq '.pushed_at[0:10]' 2>$null
        $status = if ($pushed) { "自维护（最后推送 $pushed）" } else { '未知' }
    } elseif (-not $latest.ok) {
        $status = '查不到 release（可能走插件源分发）'
    }

    $results += [pscustomobject]@{
        InternalName = $p.InternalName
        Name         = $p.Name
        Listed       = $p.AssemblyVersion
        UpstreamTag  = $latest.tag
        UpstreamVer  = $upstream
        Published    = $latest.date
        Repo         = $repo
        Status       = $status
    }
}

# ---- 输出表格 ----
$results | ForEach-Object {
    $mark = switch -Wildcard ($_.Status) {
        '最新*'      { 'OK ' }
        '有更新'     { '!! ' }
        '自维护*'    { '[-] ' }
        default      { '?? ' }
    }
    "{0}{1,-24} 清单={2,-14} 上游={3,-14} {4}" -f $mark, $_.InternalName, $_.Listed, ($_.UpstreamTag ?? '-'), $_.Status
}

Write-Host ''
$hasUpdate = @($results | Where-Object Status -eq '有更新')
if ($hasUpdate.Count -gt 0) {
    Write-Host ">>> 有更新的插件 $($hasUpdate.Count) 个：" -ForegroundColor Yellow
    foreach ($u in $hasUpdate) {
        Write-Host ("    {0}: {1} -> {2}  (https://github.com/{3}/releases)" -f $u.InternalName, $u.Listed, $u.UpstreamTag, $u.Repo)
    }
    Write-Host '    更新方法：pwsh -File scripts/update-entry.js <插件InternalName>（自动拉上游最新条目替换本库清单）。'
} else {
    Write-Host '>>> 全部插件均为最新。' -ForegroundColor Green
}

# ---- 落盘状态快照 ----
$statusPath = Join-Path $RepoDir 'upstream-status.json'
@{
    checkedAt = (Get-Date -Format 'yyyy-MM-ddTHH:mm:sszzz')
    plugins   = $results
} | ConvertTo-Json -Depth 5 | Set-Content $statusPath -Encoding UTF8
Write-Host "状态快照已写入 $statusPath"
