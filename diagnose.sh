#!/bin/bash

# Troubleshooting and diagnostic script

echo "=========================================="
echo "Medical Assistant - Diagnostics"
echo "=========================================="
echo ""

# Check Node.js version
echo "System Information:"
echo "-------------------"
echo "Node.js version: $(node --version 2>&1)"
echo "npm version: $(npm --version 2>&1)"
echo "Current directory: $(pwd)"
echo ""

# Check directory structure
echo "Directory Structure:"
echo "--------------------"
if [ -d "backend" ]; then
    echo "✓ backend/ exists"
    [ -d "backend/src" ] && echo "  ✓ backend/src/ exists" || echo "  ✗ backend/src/ missing"
    [ -f "backend/package.json" ] && echo "  ✓ backend/package.json exists" || echo "  ✗ backend/package.json missing"
    [ -d "backend/node_modules" ] && echo "  ✓ backend/node_modules/ exists" || echo "  ✗ backend/node_modules/ missing"
else
    echo "✗ backend/ missing"
fi

if [ -d "frontend" ]; then
    echo "✓ frontend/ exists"
    [ -d "frontend/src" ] && echo "  ✓ frontend/src/ exists" || echo "  ✗ frontend/src/ missing"
    [ -f "frontend/package.json" ] && echo "  ✓ frontend/package.json exists" || echo "  ✗ frontend/package.json missing"
    [ -d "frontend/node_modules" ] && echo "  ✓ frontend/node_modules/ exists" || echo "  ✗ frontend/node_modules/ missing"
else
    echo "✗ frontend/ missing"
fi
echo ""

# Check backend configuration
echo "Backend Configuration:"
echo "----------------------"
if [ -f "backend/package.json" ]; then
    echo "package.json found"
    echo "  Name: $(grep '"name"' backend/package.json | head -1)"
    echo "  Scripts:"
    grep -A 5 '"scripts"' backend/package.json | grep -v '"scripts"' | head -5
    echo ""
    
    # Check for common dependencies
    echo "  Common dependencies:"
    grep -q '"express"' backend/package.json && echo "    ✓ express" || echo "    - express"
    grep -q '"fastify"' backend/package.json && echo "    ✓ fastify" || echo "    - fastify"
    grep -q '"cors"' backend/package.json && echo "    ✓ cors" || echo "    - cors"
    grep -q '"dotenv"' backend/package.json && echo "    ✓ dotenv" || echo "    - dotenv"
    grep -q '"nodemon"' backend/package.json && echo "    ✓ nodemon (dev)" || echo "    - nodemon (dev)"
else
    echo "✗ backend/package.json not found"
fi
echo ""

# Check frontend configuration
echo "Frontend Configuration:"
echo "-----------------------"
if [ -f "frontend/package.json" ]; then
    echo "package.json found"
    echo "  Name: $(grep '"name"' frontend/package.json | head -1)"
    echo "  Scripts:"
    grep -A 5 '"scripts"' frontend/package.json | grep -v '"scripts"' | head -5
    echo ""
    
    # Check for common dependencies
    echo "  Common dependencies:"
    grep -q '"react"' frontend/package.json && echo "    ✓ react" || echo "    - react"
    grep -q '"vue"' frontend/package.json && echo "    ✓ vue" || echo "    - vue"
    grep -q '"vite"' frontend/package.json && echo "    ✓ vite" || echo "    - vite"
    grep -q '"react-scripts"' frontend/package.json && echo "    ✓ react-scripts" || echo "    - react-scripts"
else
    echo "✗ frontend/package.json not found"
fi
echo ""

# Check environment files
echo "Environment Files:"
echo "------------------"
[ -f "backend/.env" ] && echo "✓ backend/.env exists" || echo "✗ backend/.env missing (copy from .env.example)"
[ -f "backend/.env.example" ] && echo "✓ backend/.env.example exists" || echo "✗ backend/.env.example missing"
[ -f "frontend/.env" ] && echo "✓ frontend/.env exists" || echo "✗ frontend/.env missing (copy from .env.example)"
[ -f "frontend/.env.example" ] && echo "✓ frontend/.env.example exists" || echo "✗ frontend/.env.example missing"
echo ""

# Check for common entry points
echo "Entry Points:"
echo "-------------"
echo "Backend:"
for entry in "src/index.js" "src/server.js" "src/app.js" "index.js" "server.js"; do
    if [ -f "backend/$entry" ]; then
        echo "  ✓ Found backend/$entry"
    fi
done

echo "Frontend:"
for entry in "src/index.js" "src/main.js" "src/App.js" "src/index.jsx" "src/main.jsx"; do
    if [ -f "frontend/$entry" ]; then
        echo "  ✓ Found frontend/$entry"
    fi
done
echo ""

# Port check
echo "Port Availability:"
echo "------------------"
if command -v lsof > /dev/null; then
    if lsof -i :3000 > /dev/null 2>&1; then
        echo "✗ Port 3000 is in use (default backend port)"
    else
        echo "✓ Port 3000 is available"
    fi
    
    if lsof -i :5173 > /dev/null 2>&1; then
        echo "✗ Port 5173 is in use (default Vite port)"
    else
        echo "✓ Port 5173 is available"
    fi
else
    echo "⚠ lsof not available - cannot check ports"
fi
echo ""

echo "=========================================="
echo "Diagnostic complete!"
echo "=========================================="
echo ""
echo "Recommended actions:"
echo "1. If dependencies missing: run './install-deps.sh'"
echo "2. If configuration issues: run 'node fix-config.js'"
echo "3. If import issues: run 'node check-imports.js'"
echo "4. If .env missing: copy from .env.example"
echo ""
