# 部署配置说明

## BaseURL 配置

Hugo 的 `baseURL` 配置决定了网站链接的生成方式。

### 当前配置（推荐）

```toml
baseURL = '/'  # 相对路径
```

✅ **优点**：
- 适配任何域名或 IP 地址
- 本地开发、测试服务器、生产环境都能正常工作
- 无需修改配置即可部署

### 其他配置选项

#### 1. 开发环境（本地测试）
```toml
baseURL = 'http://localhost:1313/'
```

#### 2. 生产环境（IP 地址）
```toml
baseURL = 'http://8.130.111.124/'
```

#### 3. 生产环境（域名）
```toml
baseURL = 'https://yourdomain.com/'
```

## 部署流程

### 方案一：使用相对路径（当前配置）

```bash
# 1. 构建网站
hugo --minify

# 2. 部署到服务器
# 无需修改任何配置，直接部署 public 目录
```

### 方案二：根据环境变量设置 baseURL

创建 `deploy.sh` 脚本：

```bash
#!/bin/bash

# 根据环境变量构建
if [ "$DEPLOY_ENV" = "production" ]; then
    hugo --minify --baseURL "http://8.130.111.124/"
else
    hugo --minify --baseURL "/"
fi
```

使用方法：
```bash
# 生产环境
DEPLOY_ENV=production ./deploy.sh

# 开发/测试环境
./deploy.sh
```

### 方案三：使用多个配置文件

创建不同环境的配置文件：

**hugo.toml**（默认配置）
```toml
baseURL = '/'
```

**hugo.production.toml**（生产环境）
```toml
baseURL = 'http://8.130.111.124/'
```

使用方法：
```bash
# 生产环境构建
hugo --minify --config hugo.toml,hugo.production.toml

# 开发环境构建
hugo --minify
```

## 验证部署

部署后，检查以下内容：

### 1. 检查链接
打开浏览器访问：
- `http://8.130.111.124/`
- 点击菜单和文章链接，确认都能正常跳转

### 2. 检查生成的 HTML
```bash
grep -r "localhost" public/
```
应该没有任何 localhost 的硬编码链接。

### 3. 检查 RSS/Sitemap
```bash
cat public/index.xml | grep "http"
cat public/sitemap.xml | grep "http"
```

## 本地测试

### 测试相对路径配置
```bash
# 启动本地服务器
hugo server -D

# 访问
http://localhost:1313
```

### 测试生产配置
```bash
# 使用生产 baseURL 构建
hugo --minify --baseURL "http://8.130.111.124/"

# 启动简单 HTTP 服务器
cd public
python3 -m http.server 8080

# 访问
http://localhost:8080
```

## 推荐配置

✅ **推荐使用方案一（相对路径）**

理由：
1. 配置简单，无需维护多套配置
2. 灵活性强，适配任何部署环境
3. 开发和生产环境使用相同配置
4. 避免硬编码域名或 IP

## 常见问题

### Q: 为什么链接都跳到 localhost？
A: 检查 `hugo.toml` 中的 `baseURL` 设置，应该设置为 `/` 或实际的生产地址。

### Q: RSS 订阅地址不对怎么办？
A: RSS 地址由 `baseURL` 决定，修改 `baseURL` 后重新构建即可。

### Q: 如何在不同环境使用不同 baseURL？
A: 参考"方案二"或"方案三"，使用环境变量或多配置文件。

## 当前部署信息

- **开发环境**: `http://localhost:1313/`
- **生产环境**: `http://8.130.111.124/`
- **当前 baseURL**: `/`（相对路径，自动适配）

---

更新日期：2026-02-04
