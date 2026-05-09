# 一键 push 到 GitHub。先在 https://github.com/new 上手动建一个空仓库
# (建议名: middle-english-figures，可见性 Public，不要勾任何 README/license)，
# 然后复制本仓库下方红字的 HTTPS URL，把下面 $RemoteUrl 改了再运行此脚本。
#
# 用法（在本文件夹内打开 PowerShell，执行）:
#   powershell -ExecutionPolicy Bypass -File .\push.ps1
#
# 如果你 git 已经能 push 到 flyingcatpremium/middle-english-faculty，
# 你的认证(凭据管理器或 git-credential-manager)对新 repo 会同样生效。

$RemoteUrl = "https://github.com/flyingcatpremium/middle-english-figures.git"

Set-Location -LiteralPath $PSScriptRoot

# 之前如果有半成品 .git（沙盒尝试初始化失败留下的）先清掉
if (Test-Path .git) {
    $hasObjects = Test-Path .git\objects\pack -ErrorAction SilentlyContinue
    $hasRefs    = (Get-ChildItem .git\refs -Recurse -File -ErrorAction SilentlyContinue | Measure-Object).Count -gt 0
    if (-not ($hasObjects -or $hasRefs)) {
        Write-Host "Detected partial .git directory, removing..." -ForegroundColor Yellow
        Remove-Item -LiteralPath .git -Recurse -Force
    }
}

if (-not (Test-Path .git)) {
    git init -b main
    git config user.name "flyingcatpremium"
    git config user.email "reneewu9394@gmail.com"
}

git add .
git commit -m "Initial: Middle English historical figures directory" 2>$null

if (-not (git remote get-url origin 2>$null)) {
    git remote add origin $RemoteUrl
}

git push -u origin main
