# ⚡ 快速启动指南

## ✅ 已完成的工作

您的 Hugo 技术博客已经完成初始化！

### 📦 站点配置

- **主题**：PaperMod（技术博客最流行主题）
- **语言**：简体中文
- **标题**：PerDay30Kilo 技术博客
- **描述**：专注于量化交易、AI 技术和软件工程

### 📄 已创建的内容

1. **关于页面**（`/about`）
   - 详细的个人技术背景介绍
   - 技术栈展示
   - 核心项目介绍
   - 博客主题说明

2. **首篇文章**（`/posts/hello-world`）
   - 博客开始的宣言
   - 内容规划
   - 技术栈说明
   - 写作计划

3. **量化交易文章**（`/posts/my-quantitative-trading-journey`）
   - 量化交易开发经历
   - 技术选型思路
   - 架构演进过程
   - 核心功能实现
   - 实战经验总结

4. **导航菜单**
   - 首页、文章、归档、标签、关于

5. **自动化部署**
   - GitHub Actions 工作流
   - 推送即部署

## 🚀 下一步：配置 GitHub Pages

### 1. 访问仓库设置

打开：https://github.com/thushear/perday30kilo/settings/pages

### 2. 配置构建源

在 **Build and deployment** 部分：

- **Source**: 选择 `GitHub Actions`
- 点击保存

### 3. 触发首次部署

访问：https://github.com/thushear/perday30kilo/actions

- 点击 "Deploy Hugo site to GitHub Pages" 工作流
- 如果没有自动运行，点击 "Run workflow" 手动触发
- 等待 1-2 分钟，构建完成

### 4. 访问博客

部署成功后，访问：

**🌐 博客地址**：https://thushear.github.io/perday30kilo/

## 📝 日常使用

### 本地预览

```bash
# 进入博客目录
cd /Users/kongming/code/github-backup/perday30kilo

# 启动开发服务器
hugo server -D

# 访问 http://localhost:1313
```

### 创建新文章

```bash
# 创建文章
hugo new posts/my-new-article.md

# 编辑文章
# 设置 draft: false 后发布
```

### 发布文章

```bash
# 提交并推送
git add .
git commit -m "添加新文章：xxx"
git push

# GitHub Actions 自动部署
```

## 📂 目录结构

```
perday30kilo/
├── .github/workflows/  # GitHub Actions 配置
├── content/            # 内容目录
│   ├── about.md       # 关于页面
│   ├── archives.md    # 归档页面
│   └── posts/         # 文章目录
├── themes/PaperMod/   # 主题（子模块）
├── hugo.toml          # 站点配置
├── README.md          # 项目说明
├── DEPLOYMENT.md      # 部署指南
└── QUICKSTART.md      # 本文件
```

## 🎨 个性化配置

### 修改个人信息

编辑 `hugo.toml`：

```toml
[params]
  author = "你的名字"
  description = "博客描述"

[params.homeInfoParams]
  Title = "自定义标题"
  Content = "自定义首页内容"
```

### 修改关于页面

编辑 `content/about.md`，更新个人信息和项目经历。

### 添加社交链接

在 `hugo.toml` 中添加：

```toml
[[params.socialIcons]]
  name = "github"
  url = "https://github.com/your-username"

[[params.socialIcons]]
  name = "twitter"
  url = "https://twitter.com/your-username"

[[params.socialIcons]]
  name = "email"
  url = "mailto:your-email@example.com"
```

支持的社交图标：github, twitter, email, linkedin, rss, youtube, telegram 等。

## 🔧 常用命令

```bash
# 创建文章
hugo new posts/article-name.md

# 本地预览（包含草稿）
hugo server -D

# 本地预览（仅已发布内容）
hugo server

# 构建静态文件（生成到 public/）
hugo

# 构建并压缩
hugo --minify

# 查看 Hugo 版本
hugo version

# 查看帮助
hugo help
```

## 📚 推荐阅读

- [DEPLOYMENT.md](DEPLOYMENT.md) - 详细部署指南
- [README.md](README.md) - 项目说明
- [Hugo 官方文档](https://gohugo.io/documentation/)
- [PaperMod 主题文档](https://github.com/adityatelange/hugo-PaperMod/wiki)

## 💡 写作建议

### 文章 Front Matter 模板

```markdown
---
title: "文章标题"
date: 2026-01-28T17:30:00+08:00
draft: false
tags: ["标签1", "标签2", "标签3"]
categories: ["分类"]
description: "文章摘要（SEO 优化）"
---

## 正文开始...
```

### 常用标签示例

- 技术类：`Python`, `JavaScript`, `Go`, `SQL`
- 主题类：`量化交易`, `AI`, `Web开发`, `数据分析`
- 类型类：`教程`, `实战`, `踩坑`, `总结`

### 常用分类示例

- `量化交易`
- `Python工程`
- `AI应用`
- `Web开发`
- `技术随笔`

## ✨ 特色功能

### 代码高亮

支持所有主流编程语言的语法高亮：

\`\`\`python
def hello_world():
print("Hello, Hugo!")
\`\`\`

### 数学公式

支持 LaTeX 数学公式（需要配置）。

### 图片

```markdown
![图片描述](/images/photo.jpg)
```

图片放在 `static/images/` 目录。

### 内部链接

```markdown
[文章链接]({{< ref "posts/article-name.md" >}})
```

## 📈 SEO 优化

博客已配置：

- ✅ 自动生成 sitemap.xml
- ✅ 自动生成 RSS feed
- ✅ 语义化 HTML
- ✅ OpenGraph 标签
- ✅ Twitter Cards

## 🎯 下一步建议

1. [ ] 配置 GitHub Pages（必须）
2. [ ] 更新 `about.md` 的个人信息
3. [ ] 修改首页介绍内容
4. [ ] 添加个人社交链接
5. [ ] 开始写第一篇技术文章
6. [ ] 定期更新博客内容
7. [ ] 分享到技术社区

## 📞 需要帮助？

- **Hugo 文档**：https://gohugo.io/
- **主题问题**：https://github.com/adityatelange/hugo-PaperMod/issues
- **GitHub Pages**：https://docs.github.com/pages

---

**祝写作愉快！** 🎉

记住：**最好的博客就是持续更新的博客！** 💪
