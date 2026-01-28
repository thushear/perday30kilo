# 🚀 部署指南

本文档说明如何将 Hugo 博客部署到 GitHub Pages。

## 📋 前置条件

- GitHub 账号
- 已推送代码到 GitHub 仓库

## ⚙️ 配置 GitHub Pages

### 步骤 1：访问仓库设置

1. 打开浏览器，访问：https://github.com/thushear/perday30kilo
2. 点击仓库顶部的 **Settings**（设置）选项卡
3. 在左侧菜单中找到 **Pages** 选项

### 步骤 2：配置 Pages 构建源

在 **Build and deployment** 部分：

1. **Source**（源）选择：**GitHub Actions**
2. 点击保存

### 步骤 3：等待自动部署

1. 访问 **Actions** 选项卡：https://github.com/thushear/perday30kilo/actions
2. 查看 "Deploy Hugo site to GitHub Pages" 工作流
3. 等待构建完成（通常 1-2 分钟）
4. ✅ 构建成功后，博客将自动部署

### 步骤 4：访问博客

部署完成后，博客将在以下地址可访问：

**博客地址**：https://thushear.github.io/perday30kilo/

## 🔄 后续更新流程

每次更新博客内容后：

```bash
# 1. 进入博客目录
cd /Users/kongming/code/github-backup/perday30kilo

# 2. 创建新文章（可选）
hugo new posts/new-article.md

# 3. 编辑文章，设置 draft: false

# 4. 提交更改
git add .
git commit -m "添加新文章：xxx"
git push

# 5. GitHub Actions 会自动构建和部署
```

## 📝 写作流程

### 创建新文章

```bash
# 创建文章
hugo new posts/article-name.md

# 文章会自动创建在：
# content/posts/article-name.md
```

### 文章 Front Matter

```markdown
---
title: "文章标题"
date: 2026-01-28T17:30:00+08:00
draft: false # 设置为 false 才会发布
tags: ["标签1", "标签2"]
categories: ["分类"]
description: "文章描述"
---

文章正文内容...
```

### 本地预览

```bash
# 启动开发服务器（包含草稿）
hugo server -D

# 访问 http://localhost:1313
# 支持热重载，修改后自动刷新
```

### 发布文章

1. 确保 `draft: false`
2. 提交并推送到 GitHub
3. 自动触发部署

## 🎨 自定义配置

### 修改站点信息

编辑 `hugo.toml` 文件：

```toml
baseURL = 'https://thushear.github.io/perday30kilo/'
title = '你的博客标题'

[params]
  author = "你的名字"
  description = "博客描述"
```

### 修改首页信息

在 `hugo.toml` 中修改：

```toml
[params.homeInfoParams]
  Title = "首页标题"
  Content = """
  首页内容...
  """
```

### 添加社交链接

```toml
[[params.socialIcons]]
  name = "github"
  url = "https://github.com/your-username"

[[params.socialIcons]]
  name = "twitter"
  url = "https://twitter.com/your-username"
```

### 修改菜单

```toml
[[menu.main]]
  name = "菜单名称"
  url = "/path/"
  weight = 1  # 数字越小越靠前
```

## 🐛 常见问题

### Q1: Actions 构建失败

**解决方案**：

1. 检查 `.github/workflows/hugo.yml` 文件是否正确
2. 确保主题子模块已正确添加
3. 查看 Actions 日志获取具体错误信息

### Q2: 页面显示 404

**解决方案**：

1. 确认 GitHub Pages 已正确配置为 GitHub Actions
2. 检查 `hugo.toml` 中的 `baseURL` 是否正确
3. 等待几分钟，DNS 生效需要时间

### Q3: 主题样式不显示

**解决方案**：

1. 确保主题子模块已正确拉取：
   ```bash
   git submodule update --init --recursive
   ```
2. 检查 `hugo.toml` 中是否设置了 `theme = 'PaperMod'`

### Q4: 文章不显示

**解决方案**：

1. 确认文章的 `draft: false`
2. 检查文章是否在 `content/posts/` 目录下
3. 本地运行 `hugo server -D` 测试

## 📚 更多资源

- **Hugo 官方文档**：https://gohugo.io/documentation/
- **PaperMod 主题文档**：https://github.com/adityatelange/hugo-PaperMod/wiki
- **GitHub Pages 文档**：https://docs.github.com/pages

## ✅ 部署检查清单

- [ ] GitHub Pages 配置为 GitHub Actions
- [ ] 查看 Actions 工作流是否运行成功
- [ ] 访问博客地址确认部署成功
- [ ] 测试导航菜单是否正常
- [ ] 检查文章显示是否正确
- [ ] 验证关于页面内容
- [ ] 测试标签和归档功能

---

**博客地址**：https://thushear.github.io/perday30kilo/

**仓库地址**：https://github.com/thushear/perday30kilo

祝写作愉快！🎉
