#!/bin/bash

# Project Setup Script for Medical Assistant
# This script helps configure the project after code upload

echo "======================================"
echo "Medical Assistant - Project Setup"
echo "======================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if directory has files
check_directory() {
    local dir=$1
    if [ -d "$dir/src" ]; then
        # Check for actual source files (not templates)
        local file_count=$(find "$dir/src" -type f \( -name "*.js" -o -name "*.ts" -o -name "*.jsx" -o -name "*.tsx" \) ! -name ".*" ! -name "*.template.*" 2>/dev/null | wc -l)
        if [ "$file_count" -gt 0 ]; then
            return 0
        fi
    fi
    return 1
}

# Function to detect framework in package.json
detect_framework() {
    local package_json=$1
    if [ -f "$package_json" ]; then
        if grep -q '"react"' "$package_json"; then
            echo "react"
        elif grep -q '"vue"' "$package_json"; then
            echo "vue"
        elif grep -q '"express"' "$package_json"; then
            echo "express"
        elif grep -q '"fastify"' "$package_json"; then
            echo "fastify"
        elif grep -q '"next"' "$package_json"; then
            echo "next"
        else
            echo "unknown"
        fi
    else
        echo "none"
    fi
}

echo "Checking project structure..."
echo ""

# Check Backend
echo -e "${YELLOW}Backend:${NC}"
if check_directory "backend"; then
    echo -e "${GREEN}✓ Backend code detected${NC}"
    BACKEND_FRAMEWORK=$(detect_framework "backend/package.json")
    echo "  Framework: $BACKEND_FRAMEWORK"
    
    # Check if dependencies are installed
    if [ ! -d "backend/node_modules" ]; then
        echo -e "${YELLOW}  Installing backend dependencies...${NC}"
        cd backend && npm install && cd ..
    else
        echo -e "${GREEN}  ✓ Dependencies installed${NC}"
    fi
else
    echo -e "${RED}✗ No backend code found${NC}"
    echo "  Please upload your backend code to the backend/ directory"
fi

echo ""

# Check Frontend
echo -e "${YELLOW}Frontend:${NC}"
if check_directory "frontend"; then
    echo -e "${GREEN}✓ Frontend code detected${NC}"
    FRONTEND_FRAMEWORK=$(detect_framework "frontend/package.json")
    echo "  Framework: $FRONTEND_FRAMEWORK"
    
    # Check if dependencies are installed
    if [ ! -d "frontend/node_modules" ]; then
        echo -e "${YELLOW}  Installing frontend dependencies...${NC}"
        cd frontend && npm install && cd ..
    else
        echo -e "${GREEN}  ✓ Dependencies installed${NC}"
    fi
else
    echo -e "${RED}✗ No frontend code found${NC}"
    echo "  Please upload your frontend code to the frontend/ directory"
fi

echo ""
echo "======================================"
echo "Next Steps:"
echo "======================================"
echo ""
echo "1. Backend: cd backend && npm run dev"
echo "2. Frontend: cd frontend && npm run dev"
echo ""
echo "For more information, see README.md in each directory"
echo ""
