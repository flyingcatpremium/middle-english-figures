# 一次性推送：清掉残留 lock，提交全部改动并推到 main
# 用法：在本文件夹打开 PowerShell，执行
#   powershell -ExecutionPolicy Bypass -File .\push-now.ps1

Set-Location -LiteralPath $PSScriptRoot

if (Test-Path .git\index.lock) {
    Remove-Item .git\index.lock -Force -ErrorAction SilentlyContinue
}

# 清理 git add 留下的临时对象（Cowork 沙盒 add 没清干净）
Get-ChildItem .git\objects -Directory -ErrorAction SilentlyContinue | ForEach-Object {
    Get-ChildItem $_.FullName -Filter "tmp_obj_*" -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
}

git config user.name "flyingcatpremium"
git config user.email "reneewu9394@gmail.com"

git add -A

$msg = @"
Unify directory cards, simplify add-entry to name prompt, standardize body images to book size

- 卡片高度固定 80px，长名字单行省略号截断，隐藏第四行（已编辑/原始/用户添加），所有卡片视觉统一
- '+ 新建' 改为 prompt() 只让粘贴/输入名字，不再要填一长串字段；自动从空格分姓名、生成 initials
- 简介/作品/事件/关系/备注 等栏目里粘贴的图片统一为约 5:7 竖版书形 (180x252)，居中、加边框/阴影；带 .icon 类的小图保留行内大小
- 同步 build_figures.py 与 index.html，避免下次重跑生成器覆盖手改
- 顺手把这一批未提交的非内容性 LF/CRLF 行尾差异(README/DEPLOY/push.ps1/wrangler/.gitignore)一并入库
"@

git commit -m $msg
if ($LASTEXITCODE -ne 0) {
    Write-Host "提交失败（也许没有变化），仍尝试 push..." -ForegroundColor Yellow
}

git push origin main
