# Woodpecker CI Setup Guide

This guide shows you how to configure your GitHub repository with the locally running Woodpecker CI instance.

## 🎯 Current Status

✅ **Woodpecker CI is running at**: http://johnnyjdev.nvidia.com:8000  
✅ **Local CI pipeline tested successfully**  
✅ **All project files are ready**

## 🔧 GitHub Integration Setup

Since you've already pushed the code to GitHub, here's how to connect it to Woodpecker:

### Option 1: Manual Repository Configuration (Recommended for local testing)

1. **Access Woodpecker Web UI**:
   ```
   http://johnnyjdev.nvidia.com:8000
   ```

2. **Login** using the admin account:
   - Username: `admin`
   - No password required (WOODPECKER_OPEN=true)

3. **Add Repository Manually**:
   - Go to "Repositories" section
   - Click "Add Repository"
   - Enter your repository details:
     ```
     Repository URL: https://github.com/nvidia/johnnynv/Woodpecker_POC
     Repository Name: Woodpecker_POC
     ```

### Option 2: GitHub App Integration (For production use)

To set up full GitHub integration, you would need to:

1. **Create a GitHub App**:
   - Go to GitHub Settings → Developer settings → GitHub Apps
   - Create a new GitHub App with these permissions:
     - Repository permissions:
       - Contents: Read
       - Metadata: Read
       - Pull requests: Read & Write
       - Commit statuses: Read & Write
     - Subscribe to events:
       - Push
       - Pull request
       - Pull request review

2. **Update Woodpecker Configuration**:
   ```yaml
   # In docker-compose.yml
   environment:
     - WOODPECKER_GITHUB=true
     - WOODPECKER_GITHUB_CLIENT=your_github_app_id
     - WOODPECKER_GITHUB_SECRET=your_github_app_secret
     - WOODPECKER_GITHUB_WEBHOOK_SECRET=your_webhook_secret
   ```

## 🚀 Triggering CI Pipelines

### Automatic Triggers
The `.woodpecker.yml` configuration will automatically trigger on:
- ✅ Push to main/master/develop branches
- ✅ Pull requests
- ✅ Tag creation
- ✅ Feature branch pushes (feature/*)

### Manual Testing
You can test the pipeline locally using the demo script:
```bash
./ci-demo.sh
```

## 🧪 Pipeline Features Demonstrated

Your Woodpecker CI configuration includes these advanced features:

### 🔄 **Build Matrix**
- Tests across Python 3.9, 3.10, and 3.11
- Parallel execution for faster feedback

### 🔍 **Code Quality Pipeline**
- **Black**: Code formatting
- **Flake8**: Style checking  
- **MyPy**: Type checking
- **Safety**: Security scanning
- **Bandit**: Security analysis

### 🧪 **Testing Pipeline**
- **Unit Tests**: pytest with detailed reporting
- **Coverage**: HTML and terminal reports
- **Integration Tests**: Application startup verification
- **Performance Tests**: Benchmark testing (on tags)

### 🏗️ **Build & Deploy**
- **Artifact Generation**: Compiled code and build info
- **Deployment Preparation**: Package creation
- **Conditional Execution**: Branch and event-based triggers

### 💾 **Optimization Features**
- **Caching**: pip dependencies cached by Python version
- **Services**: Mock database for integration testing
- **Notifications**: Build status reporting

## 📊 Pipeline Results

Last successful local run:
```
✅ Code Quality: PASSED
✅ Unit Tests: 7/7 PASSED  
✅ Coverage: 67%
✅ Build: SUCCESS
```

## 🔗 Quick Actions

1. **View Web UI**: http://johnnyjdev.nvidia.com:8000
2. **Test Local Pipeline**: `./ci-demo.sh`
3. **Check Service Status**: `podman-compose ps`
4. **View Logs**: `podman-compose logs -f`
5. **Stop Services**: `podman-compose down`

## 📁 Project Structure

```
Woodpecker_POC/
├── .woodpecker.yml       # CI/CD pipeline configuration
├── app.py               # Demo Python application
├── test_app.py          # Unit tests
├── requirements.txt     # Python dependencies
├── index.html          # Static web page
├── ci-demo.sh          # Local CI simulation
├── docker-compose.yml  # Woodpecker services
├── README.md           # Project documentation
└── dist/               # Build artifacts
    ├── app.py
    ├── index.html
    └── build_info.json
```

## 🎓 Learning Outcomes

This demo project showcases:

- ✅ **Multi-stage CI/CD pipelines**
- ✅ **Build matrices and parallel execution**
- ✅ **Comprehensive code quality checks**
- ✅ **Automated testing and coverage**
- ✅ **Conditional pipeline execution**
- ✅ **Artifact generation and deployment prep**
- ✅ **Service integration and caching**
- ✅ **Local CI environment setup**

Perfect for learning modern CI/CD practices with Woodpecker! 🪶

---

**Next Steps**: Try making changes to the code and watch the pipeline automatically trigger quality checks and tests!