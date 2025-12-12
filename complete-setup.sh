#!/bin/bash

# Master Setup Script
# Complete setup workflow after code upload

set -e  # Exit on error

echo "=========================================="
echo "Medical Assistant - Complete Setup"
echo "=========================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

step_number=1

print_step() {
    echo ""
    echo -e "${BLUE}Step $step_number: $1${NC}"
    echo "----------------------------------------"
    ((step_number++))
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Step 1: Check project structure
print_step "Checking Project Structure"
./setup.sh

# Step 2: Auto-fix configurations
print_step "Auto-fixing Configurations"
node fix-config.js

# Step 3: Install dependencies
print_step "Installing Dependencies"

# Backend
if [ -d "backend/src" ] && [ -f "backend/package.json" ]; then
    echo "Installing backend dependencies..."
    cd backend
    if npm install; then
        print_success "Backend dependencies installed"
    else
        print_error "Failed to install backend dependencies"
        exit 1
    fi
    cd ..
else
    print_warning "Skipping backend - no code found"
fi

# Frontend
if [ -d "frontend/src" ] && [ -f "frontend/package.json" ]; then
    echo "Installing frontend dependencies..."
    cd frontend
    if npm install; then
        print_success "Frontend dependencies installed"
    else
        print_error "Failed to install frontend dependencies"
        exit 1
    fi
    cd ..
else
    print_warning "Skipping frontend - no code found"
fi

# Step 4: Check for import issues
print_step "Checking Imports and Paths"
node check-imports.js

# Step 5: Environment setup
print_step "Environment Configuration"

if [ -f "backend/.env.example" ] && [ ! -f "backend/.env" ]; then
    echo "Creating backend/.env from template..."
    cp backend/.env.example backend/.env
    print_success "Created backend/.env - please configure it"
else
    print_warning "Backend .env already exists or template not found"
fi

if [ -f "frontend/.env.example" ] && [ ! -f "frontend/.env" ]; then
    echo "Creating frontend/.env from template..."
    cp frontend/.env.example frontend/.env
    print_success "Created frontend/.env - please configure it"
else
    print_warning "Frontend .env already exists or template not found"
fi

# Final summary
echo ""
echo "=========================================="
echo "Setup Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo ""
echo "1. Configure environment variables:"
echo "   - Edit backend/.env with your settings"
echo "   - Edit frontend/.env with your settings"
echo ""
echo "2. Start the backend:"
echo "   cd backend && npm run dev"
echo ""
echo "3. Start the frontend (in a new terminal):"
echo "   cd frontend && npm run dev"
echo ""
echo "For more information, see SETUP_GUIDE.md"
echo ""
