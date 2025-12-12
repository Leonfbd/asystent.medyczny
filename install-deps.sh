#!/bin/bash

# Dependency installer helper
# Detects framework and suggests/installs common dependencies

echo "======================================"
echo "Dependency Helper"
echo "======================================"
echo ""

install_backend_deps() {
    echo "Checking backend dependencies..."
    cd backend || return
    
    # Check if package.json exists and has dependencies
    if [ -f "package.json" ]; then
        echo "Found package.json, installing dependencies..."
        npm install
        
        # Suggest common backend packages if not present
        if ! grep -q "express" package.json && ! grep -q "fastify" package.json; then
            echo ""
            echo "Tip: Common backend frameworks:"
            echo "  - Express: npm install express cors dotenv"
            echo "  - Fastify: npm install fastify @fastify/cors dotenv"
        fi
        
        if ! grep -q "nodemon" package.json; then
            echo ""
            echo "Tip: For development, consider adding nodemon:"
            echo "  npm install --save-dev nodemon"
        fi
    else
        echo "No package.json found in backend/"
    fi
    
    cd ..
}

install_frontend_deps() {
    echo ""
    echo "Checking frontend dependencies..."
    cd frontend || return
    
    # Check if package.json exists and has dependencies
    if [ -f "package.json" ]; then
        echo "Found package.json, installing dependencies..."
        npm install
        
        # Check for Vite configuration
        if grep -q "vite" package.json && [ ! -f "vite.config.js" ]; then
            echo ""
            echo "Detected Vite but no vite.config.js found."
            echo "You may need to create one. See .vite.config.template.js"
        fi
    else
        echo "No package.json found in frontend/"
    fi
    
    cd ..
}

# Main execution
install_backend_deps
install_frontend_deps

echo ""
echo "======================================"
echo "Done! Run './setup.sh' to verify setup"
echo "======================================"
