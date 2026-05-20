<#
PowerShell 脚本：在 Windows 上根据仓库中的 dotfiles 创建备份并建立符号链接（或回退为 Junction/复制）。
用法：以管理员或启用开发者模式的普通用户运行以允许创建符号链接。
运行示例：
    powershell -ExecutionPolicy Bypass -File .\apply.ps1
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# 自提权：非管理员时自动以管理员身份重新运行
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $scriptPath = if ($PSScriptRoot) { Join-Path $PSScriptRoot $MyInvocation.MyCommand.Name } else { $MyInvocation.MyCommand.Definition }
    Write-Host "[ELEVATE] Requesting administrator privileges..."
    $process = Start-Process PowerShell -ArgumentList "-NoExit -ExecutionPolicy Bypass -NoProfile -File `"$scriptPath`"" -Verb RunAs -Wait -PassThru
    exit $process.ExitCode
}

# 脚本所在目录
$RootDir = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path -Parent $MyInvocation.MyCommand.Definition }
$SourceDir = Join-Path $RootDir 'dotfiles'
$HomeDir = $env:USERPROFILE

Write-Host "Starting dotfiles deployment from: $SourceDir"

# 确保必要目录存在
$ConfigDir = Join-Path $HomeDir '.config'
@($ConfigDir, "$env:LOCALAPPDATA\nvim", "$env:APPDATA\uv", "$env:APPDATA\alacritty") | ForEach-Object {
    if (-not (Test-Path $_)) {
        New-Item -ItemType Directory -Path $_ -Force | Out-Null
    }
}

# 判断路径是否为目录（兼容 PS 5.1 / 6+）
function Test-IsDirectory {
    param([string] $Path)
    $item = Get-Item -LiteralPath $Path -Force -ErrorAction SilentlyContinue
    if ($item) { return $item.PSIsContainer }
    return $false
}

function Create-Symlink {
    param(
        [Parameter(Mandatory=$true)] [string] $SourcePath,
        [Parameter(Mandatory=$true)] [string] $TargetPath
    )

    if (-not (Test-Path $SourcePath)) {
        Write-Warning "Source does not exist: $SourcePath. Skipping."
        return
    }

    $sourceIsDir = Test-IsDirectory $SourcePath
    $existing = Get-Item -LiteralPath $TargetPath -Force -ErrorAction SilentlyContinue

    if ($existing) {
        # 如果已是正确指向源的符号链接/junction，跳过
        if ($existing.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
            $linkTarget = $existing.Target
            if ($linkTarget) {
                # 规范化路径后再比较（支持相对路径的符号链接）
                try {
                    $resolvedTarget = [System.IO.Path]::GetFullPath($linkTarget)
                } catch {
                    $resolvedTarget = $linkTarget
                }
                $resolvedSource = [System.IO.Path]::GetFullPath($SourcePath)
                if ($resolvedTarget.TrimEnd('\') -eq $resolvedSource.TrimEnd('\')) {
                    Write-Host "[OK]     Symlink already exists: $TargetPath -> $SourcePath"
                    return
                }
            }
        }

        # 备份现有目标
        $bakPath = "$TargetPath.bak"
        Write-Host "[BACKUP] Backing up existing path: $TargetPath -> $bakPath"
        if (Test-Path $bakPath) {
            $bakPath = "$bakPath.$((Get-Date).ToString('yyyyMMddHHmmss'))"
        }
        Move-Item -LiteralPath $TargetPath -Destination $bakPath -Force
    }

    # 确保父目录存在
    $parent = Split-Path -Parent $TargetPath
    if (-not (Test-Path $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }

    # 尝试创建符号链接
    try {
        New-Item -ItemType SymbolicLink -Path $TargetPath -Target $SourcePath -Force | Out-Null
        Write-Host "[LINK]   Created symlink: $TargetPath -> $SourcePath"
        return
    } catch {
        Write-Warning "Failed to create symbolic link: $($_.Exception.Message)"
    }

    # 回退方案
    if ($sourceIsDir) {
        # 目录：先尝试 Junction（mklink /J）
        $cmdOutput = cmd /c "mklink /J `"$TargetPath`" `"$SourcePath`"" 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[LINK]   Created junction: $TargetPath -> $SourcePath"
        } else {
            Write-Warning "Failed to create junction ($cmdOutput). Copying directory as fallback..."
            try {
                Copy-Item -Path $SourcePath -Destination $TargetPath -Recurse -Force
                Write-Host "[COPY]   Copied directory: $TargetPath <- $SourcePath"
            } catch {
                Write-Warning "Failed to copy directory as fallback: $($_.Exception.Message)"
            }
        }
    } else {
        # 文件：回退为复制
        try {
            Copy-Item -Path $SourcePath -Destination $TargetPath -Force
            Write-Host "[COPY]   Copied file: $TargetPath <- $SourcePath"
        } catch {
            Write-Warning "Failed to copy file as fallback: $($_.Exception.Message)"
        }
    }
}

# 1. 位于 Home 目录的配置
Create-Symlink -SourcePath (Join-Path $SourceDir '.npmrc') -TargetPath (Join-Path $HomeDir '.npmrc')

# 2. 位于 ~/.config 目录的配置（wezterm / starship / opencode 在 Windows 也沿用此路径）
Create-Symlink -SourcePath (Join-Path $SourceDir 'starship.toml') -TargetPath (Join-Path $ConfigDir 'starship.toml')
# Check that wezterm submodule has been initialized (git submodule update --init)
if ((Test-Path (Join-Path $SourceDir 'wezterm')) -and -not (Test-Path (Join-Path (Join-Path $SourceDir 'wezterm') 'wezterm.lua'))) {
    Write-Warning "wezterm submodule not initialized. Run: git submodule update --init"
}
Create-Symlink -SourcePath (Join-Path $SourceDir 'wezterm') -TargetPath (Join-Path $ConfigDir 'wezterm')

$OpenCodeSource = Join-Path $SourceDir 'opencode'
$OpenCodeTarget = Join-Path $ConfigDir 'opencode'
Get-ChildItem -Path $OpenCodeSource -File | ForEach-Object {
    Create-Symlink -SourcePath $_.FullName -TargetPath (Join-Path $OpenCodeTarget $_.Name)
}

# 3. Windows 特有路径
Create-Symlink -SourcePath (Join-Path $SourceDir 'nvim') -TargetPath (Join-Path $env:LOCALAPPDATA 'nvim')
Create-Symlink -SourcePath (Join-Path $SourceDir 'uv') -TargetPath (Join-Path $env:APPDATA 'uv')
Create-Symlink -SourcePath (Join-Path $SourceDir 'alacritty') -TargetPath (Join-Path $env:APPDATA 'alacritty')

Write-Host "Deployment completed successfully!"
