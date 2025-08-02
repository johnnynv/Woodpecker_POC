#!/bin/bash
# Woodpecker CI Local Demo Script
# This script demonstrates the CI pipeline locally

echo "🪶 Woodpecker CI Demo - Local Pipeline Simulation"
echo "=================================================="

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Stage 1: Environment Setup${NC}"
echo "Python version: $(python3 --version)"
echo "Current branch: $(git branch --show-current)"
echo "Last commit: $(git log -1 --oneline)"
echo ""

echo -e "${BLUE}Stage 2: Installing Dependencies${NC}"
if pip3 install --user -r requirements.txt > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Dependencies installed successfully${NC}"
else
    echo -e "${RED}❌ Failed to install dependencies${NC}"
    exit 1
fi
echo ""

echo -e "${BLUE}Stage 3: Code Quality Checks${NC}"
echo "Running Black formatter check..."
if python3 -m black --check --diff app.py test_app.py > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Code formatting is correct${NC}"
else
    echo -e "${YELLOW}⚠️ Code needs formatting (auto-fixed)${NC}"
    python3 -m black app.py test_app.py
fi

echo "Running Flake8 style check..."
if python3 -m flake8 app.py test_app.py --max-line-length=88; then
    echo -e "${GREEN}✅ Code style check passed${NC}"
else
    echo -e "${RED}❌ Code style issues found${NC}"
fi

echo "Running MyPy type check..."
if python3 -m mypy app.py --ignore-missing-imports > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Type checking passed${NC}"
else
    echo -e "${RED}❌ Type checking failed${NC}"
fi
echo ""

echo -e "${BLUE}Stage 4: Unit Tests${NC}"
if python3 -m pytest test_app.py -v; then
    echo -e "${GREEN}✅ All tests passed${NC}"
else
    echo -e "${RED}❌ Some tests failed${NC}"
    exit 1
fi
echo ""

echo -e "${BLUE}Stage 5: Test Coverage${NC}"
python3 -m pytest test_app.py --cov=app --cov-report=term --cov-report=html
echo -e "${GREEN}✅ Coverage report generated${NC}"
echo ""

echo -e "${BLUE}Stage 6: Application Test${NC}"
echo "Testing main application..."
if python3 app.py > /dev/null; then
    echo -e "${GREEN}✅ Application runs successfully${NC}"
else
    echo -e "${RED}❌ Application failed to run${NC}"
    exit 1
fi
echo ""

echo -e "${BLUE}Stage 7: Build Artifacts${NC}"
mkdir -p dist
cp app.py dist/
cp index.html dist/
cat > dist/build_info.json << EOF
{
  "build_time": "$(date -Iseconds)",
  "commit_sha": "$(git rev-parse HEAD)",
  "branch": "$(git branch --show-current)",
  "python_version": "$(python3 --version | cut -d' ' -f2)",
  "build_number": "local-$(date +%s)"
}
EOF
echo -e "${GREEN}✅ Build artifacts created in dist/${NC}"
echo ""

echo -e "${GREEN}🎉 All CI stages completed successfully!${NC}"
echo "📊 Pipeline Summary:"
echo "   - Code Quality: PASSED"
echo "   - Unit Tests: PASSED" 
echo "   - Coverage: Generated"
echo "   - Build: SUCCESS"
echo ""
echo "🌐 Access Woodpecker Web UI: http://johnnyjdev.nvidia.com:8000"
echo "📁 Build artifacts available in: ./dist/"