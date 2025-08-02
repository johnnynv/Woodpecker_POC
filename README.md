# Woodpecker CI 演示项目 🪶

这是一个演示Woodpecker CI各种特性的示例项目，包含完整的CI/CD流水线配置。

## 项目结构

```
Woodpecker_POC/
├── app.py                 # 主应用程序
├── test_app.py           # 单元测试
├── requirements.txt      # Python依赖
├── index.html           # 静态HTML页面
├── .woodpecker.yml      # Woodpecker CI配置
├── docker-compose.yml   # Woodpecker服务配置
└── README.md           # 项目说明
```

## 快速开始

### 1. 启动Woodpecker CI服务

```bash
# 启动Woodpecker服务
podman-compose up -d

# 查看服务状态
podman-compose ps

# 查看日志
podman-compose logs -f
```

### 2. 访问Woodpecker Web界面

打开浏览器访问: http://localhost:8000

默认管理员账号: `admin` (无密码)

### 3. 本地测试应用

```bash
# 安装依赖
pip install -r requirements.txt

# 运行应用
python app.py

# 运行测试
pytest test_app.py -v

# 代码质量检查
black --check app.py test_app.py
flake8 app.py test_app.py
mypy app.py
```

## CI/CD 特性演示

### 🔧 构建矩阵
- 多Python版本测试 (3.9, 3.10, 3.11)
- 并行执行不同版本的测试

### 📊 代码质量
- **Black**: 代码格式化检查
- **Flake8**: 代码风格检查
- **MyPy**: 静态类型检查
- **Safety**: 安全依赖扫描
- **Bandit**: 安全代码分析

### 🧪 测试
- **单元测试**: pytest测试框架
- **测试覆盖率**: 生成详细的覆盖率报告
- **集成测试**: 应用启动测试
- **性能测试**: 基准性能测试

### 🎯 条件执行
- 分支条件: 不同分支执行不同步骤
- 事件条件: push/pull_request/tag触发
- 矩阵条件: 特定Python版本执行特定任务

### 📦 构建产物
- 编译Python代码
- 生成构建信息JSON
- 创建部署包

### 🚀 部署流程
- 仅在主分支执行部署准备
- 创建dist目录和部署文件
- 环境特定的部署配置

### 🔄 服务集成
- 模拟数据库服务
- 服务依赖管理

### 💾 缓存优化
- pip缓存按Python版本分离
- 加速依赖安装

## 配置说明

### Woodpecker配置 (.woodpecker.yml)

```yaml
when:
  - event: [push, pull_request, tag]
  - branch: [main, master, develop, feature/*]

matrix:
  PYTHON_VERSION: ["3.9", "3.10", "3.11"]
```

### 主要步骤

1. **setup**: 环境准备
2. **install-dependencies**: 依赖安装
3. **code-quality**: 代码质量检查 (并行)
4. **unit-tests**: 单元测试 (并行)
5. **test-coverage**: 测试覆盖率
6. **security-scan**: 安全扫描
7. **build-artifacts**: 构建产物
8. **html-validation**: 静态文件检查
9. **integration-tests**: 集成测试
10. **performance-tests**: 性能测试
11. **deploy-preparation**: 部署准备
12. **notification**: 构建通知

## 触发条件示例

| 条件 | 执行步骤 |
|------|----------|
| 任何分支 push | 基础流水线 |
| 主分支 push | 包含安全扫描和部署准备 |
| 创建 tag | 包含性能测试 |
| Pull Request | 代码质量检查和测试 |

## 使用建议

1. **开发阶段**: 使用feature分支，触发基础检查
2. **测试阶段**: 合并到develop分支，运行完整测试
3. **发布阶段**: 合并到main分支，执行完整流水线
4. **版本发布**: 创建tag，运行性能测试

## 故障排除

### 查看日志
```bash
# Woodpecker服务日志
podman-compose logs woodpecker-server
podman-compose logs woodpecker-agent

# 特定容器日志
podman logs <container_id>
```

### 重启服务
```bash
# 重启所有服务
podman-compose restart

# 重新构建并启动
podman-compose up -d --build
```

### 清理环境
```bash
# 停止并删除容器
podman-compose down

# 清理数据卷
podman-compose down -v
```

## 扩展功能

这个配置可以轻松扩展：

- 添加更多测试类型 (e2e, API测试)
- 集成更多代码质量工具
- 添加容器化构建
- 配置多环境部署
- 集成通知系统 (Slack, Email)
- 添加数据库迁移步骤

## 技术栈

- **CI/CD**: Woodpecker CI
- **容器**: Podman/Docker
- **语言**: Python 3.9+
- **测试**: pytest, pytest-cov
- **代码质量**: black, flake8, mypy, safety, bandit
- **前端**: HTML5

---

🎉 享受使用Woodpecker CI进行现代化的CI/CD体验！