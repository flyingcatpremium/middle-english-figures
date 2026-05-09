# 部署到 GitHub + Cloudflare Pages

完全沿用 cf-deploy 的方式。两步走。

## 1. 推到 GitHub

**两步**：

(a) 浏览器打开 https://github.com/new，
- Owner = `flyingcatpremium`
- Repository name = `middle-english-figures`
- Visibility = Public（CF Pages 接 Public 最直）
- **不要**勾 README / .gitignore / license（仓库要空的）
- 点 Create repository

(b) 在本文件夹打开 PowerShell，运行：

```powershell
powershell -ExecutionPolicy Bypass -File .\push.ps1
```

`push.ps1` 会自动 `git init` / `git add` / `git commit` / `git remote add origin ...` / `git push -u origin main`。

如果你 push 时被要求登录 GitHub，VS Code / Windows Credential Manager / git-credential-manager 都会接管——你旧仓库 `middle-english-faculty` 已经走通这一路，新 repo 同账号同样生效。

> 想用别的仓库名？编辑 `push.ps1` 第 11 行的 `$RemoteUrl` 即可。

## 2. 接入 Cloudflare Pages

1. 登录 https://dash.cloudflare.com/ → 左侧栏 **Workers & Pages** → **Create application** → **Pages** → **Connect to Git**
2. 授权 GitHub，选刚刚推上去的 `middle-english-figures` 仓库
3. 设置：
   - **Project name**: 随意，例如 `middle-english-figures`
   - **Production branch**: `main`
   - **Build command**: 留空
   - **Build output directory**: `/`
4. 点 **Save and Deploy**

完成后会拿到一个 `*.pages.dev` 域名。后续每次 `git push` 到 `main`，Cloudflare 自动重新部署。

## 自定义域名（可选）

在 Pages 项目里 **Custom domains** 加一个你拥有的域名（例如 `figures.your-domain.com`），CF 会自动签 SSL。

## 替换肖像

把 JPG/PNG 放到 `photos/` 文件夹，命名最好简洁（例如 `chaucer.jpg`），然后：

- **方案 A（页面内编辑）**：打开站点，鼠标悬停在大幅肖像上，下方会出现一行小输入条，填入文件名（如 `chaucer.jpg`）即可，更改保存在你这台浏览器的 localStorage。
- **方案 B（写回源码）**：编辑 `index.html`，找到对应人物的 `"photo": ""`，改为 `"photo": "chaucer.jpg"`，git push 上线给所有人看。
