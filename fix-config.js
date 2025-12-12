#!/usr/bin/env node

/**
 * Configuration Auto-Fixer
 * Automatically detects and fixes common configuration issues
 */

const fs = require('fs');
const path = require('path');

const BACKEND_DIR = path.join(__dirname, 'backend');
const FRONTEND_DIR = path.join(__dirname, 'frontend');

// Helper functions
function fileExists(filePath) {
    try {
        return fs.existsSync(filePath);
    } catch (error) {
        // Ignore errors from invalid paths or permissions
        return false;
    }
}

function readJSON(filePath) {
    try {
        return JSON.parse(fs.readFileSync(filePath, 'utf8'));
    } catch (error) {
        // Return null for invalid JSON or missing files
        return null;
    }
}

function writeJSON(filePath, data) {
    fs.writeFileSync(filePath, JSON.stringify(data, null, 2) + '\n');
}

// Check and fix backend configuration
function fixBackendConfig() {
    console.log('Checking backend configuration...');
    const packageJsonPath = path.join(BACKEND_DIR, 'package.json');
    
    if (!fileExists(packageJsonPath)) {
        console.log('  ⚠ Backend package.json not found');
        return;
    }

    const packageJson = readJSON(packageJsonPath);
    if (!packageJson) return;

    let modified = false;

    // Ensure dev script exists
    if (!packageJson.scripts) {
        packageJson.scripts = {};
        modified = true;
    }

    // Auto-detect common entry points
    const possibleEntries = [
        'src/index.js',
        'src/server.js',
        'src/app.js',
        'index.js',
        'server.js'
    ];

    let entryPoint = null;
    for (const entry of possibleEntries) {
        if (fileExists(path.join(BACKEND_DIR, entry))) {
            entryPoint = entry;
            break;
        }
    }

    if (entryPoint) {
        // Check if nodemon is in dependencies
        const hasNodemon = packageJson.dependencies?.nodemon || packageJson.devDependencies?.nodemon;
        
        if (!packageJson.scripts.dev) {
            packageJson.scripts.dev = hasNodemon 
                ? `nodemon ${entryPoint}`
                : `node ${entryPoint}`;
            modified = true;
            console.log(`  ✓ Added dev script: ${packageJson.scripts.dev}`);
        }

        if (!packageJson.scripts.start) {
            packageJson.scripts.start = `node ${entryPoint}`;
            modified = true;
            console.log(`  ✓ Added start script`);
        }
    }

    if (modified) {
        writeJSON(packageJsonPath, packageJson);
        console.log('  ✓ Backend package.json updated');
    } else {
        console.log('  ✓ Backend configuration looks good');
    }
}

// Check and fix frontend configuration
function fixFrontendConfig() {
    console.log('Checking frontend configuration...');
    const packageJsonPath = path.join(FRONTEND_DIR, 'package.json');
    
    if (!fileExists(packageJsonPath)) {
        console.log('  ⚠ Frontend package.json not found');
        return;
    }

    const packageJson = readJSON(packageJsonPath);
    if (!packageJson) return;

    let modified = false;

    // Detect framework
    const deps = { ...packageJson.dependencies, ...packageJson.devDependencies };
    
    if (deps.react || deps['react-dom']) {
        console.log('  Detected: React');
        
        if (deps.vite && !packageJson.scripts?.dev?.includes('vite')) {
            packageJson.scripts = packageJson.scripts || {};
            packageJson.scripts.dev = packageJson.scripts.dev || 'vite';
            packageJson.scripts.build = packageJson.scripts.build || 'vite build';
            packageJson.scripts.preview = packageJson.scripts.preview || 'vite preview';
            modified = true;
            console.log('  ✓ Added Vite scripts');
        }
        
        if (deps['react-scripts'] && !packageJson.scripts?.dev) {
            packageJson.scripts = packageJson.scripts || {};
            packageJson.scripts.dev = 'react-scripts start';
            packageJson.scripts.build = packageJson.scripts.build || 'react-scripts build';
            modified = true;
            console.log('  ✓ Added React Scripts');
        }
    }
    
    if (deps.vue) {
        console.log('  Detected: Vue');
        if (deps.vite && !packageJson.scripts?.dev?.includes('vite')) {
            packageJson.scripts = packageJson.scripts || {};
            packageJson.scripts.dev = packageJson.scripts.dev || 'vite';
            packageJson.scripts.build = packageJson.scripts.build || 'vite build';
            modified = true;
            console.log('  ✓ Added Vite scripts');
        }
    }

    if (modified) {
        writeJSON(packageJsonPath, packageJson);
        console.log('  ✓ Frontend package.json updated');
    } else {
        console.log('  ✓ Frontend configuration looks good');
    }
}

// Main execution
console.log('==========================================');
console.log('Configuration Auto-Fixer');
console.log('==========================================\n');

fixBackendConfig();
console.log('');
fixFrontendConfig();

console.log('\n==========================================');
console.log('Configuration check complete!');
console.log('==========================================\n');
