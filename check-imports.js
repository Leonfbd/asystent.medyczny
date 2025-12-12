#!/usr/bin/env node

/**
 * Import Path Fixer
 * Scans for common import/path issues and suggests fixes
 */

const fs = require('fs');
const path = require('path');

function findFiles(dir, extension, fileList = []) {
    if (!fs.existsSync(dir)) return fileList;
    
    const files = fs.readdirSync(dir);
    
    files.forEach(file => {
        const filePath = path.join(dir, file);
        const stat = fs.statSync(filePath);
        
        if (stat.isDirectory() && !file.startsWith('.') && file !== 'node_modules') {
            findFiles(filePath, extension, fileList);
        } else if (file.endsWith(extension)) {
            fileList.push(filePath);
        }
    });
    
    return fileList;
}

function checkImports(filePath) {
    const content = fs.readFileSync(filePath, 'utf8');
    const issues = [];
    
    // Check for absolute imports without proper configuration
    const absoluteImportRegex = /from ['"]@\//g;
    if (absoluteImportRegex.test(content)) {
        issues.push({
            file: filePath,
            type: 'absolute-import',
            message: 'Uses @ alias - ensure path alias is configured'
        });
    }
    
    // Check for imports with wrong extension
    const wrongExtRegex = /from ['"].*\.ts['"]/g;
    if (wrongExtRegex.test(content) && filePath.endsWith('.js')) {
        issues.push({
            file: filePath,
            type: 'wrong-extension',
            message: 'JS file importing .ts files - check extensions'
        });
    }
    
    // Check for missing file extensions in imports (required in ESM)
    const lines = content.split('\n');
    lines.forEach((line, idx) => {
        if (line.includes('import') && line.includes('from')) {
            const match = line.match(/from ['"](\.[^'"]+)['"]/);
            if (match && !match[1].match(/\.(js|ts|jsx|tsx|json|css|scss)$/)) {
                issues.push({
                    file: filePath,
                    type: 'missing-extension',
                    line: idx + 1,
                    message: 'Relative import missing file extension'
                });
            }
        }
    });
    
    return issues;
}

function scanProject(dir, name) {
    console.log(`\nScanning ${name}...`);
    
    const jsFiles = findFiles(path.join(__dirname, dir), '.js');
    const tsFiles = findFiles(path.join(__dirname, dir), '.ts');
    const jsxFiles = findFiles(path.join(__dirname, dir), '.jsx');
    const tsxFiles = findFiles(path.join(__dirname, dir), '.tsx');
    
    const allFiles = [...jsFiles, ...tsFiles, ...jsxFiles, ...tsxFiles];
    
    if (allFiles.length === 0) {
        console.log(`  No source files found in ${dir}/`);
        return;
    }
    
    console.log(`  Found ${allFiles.length} source files`);
    
    let totalIssues = 0;
    allFiles.forEach(file => {
        const issues = checkImports(file);
        if (issues.length > 0) {
            totalIssues += issues.length;
            console.log(`\n  ${path.relative(__dirname, file)}:`);
            issues.forEach(issue => {
                console.log(`    - ${issue.message}${issue.line ? ` (line ${issue.line})` : ''}`);
            });
        }
    });
    
    if (totalIssues === 0) {
        console.log('  ✓ No import issues detected');
    } else {
        console.log(`\n  Found ${totalIssues} potential issue(s)`);
    }
}

console.log('==========================================');
console.log('Import Path Checker');
console.log('==========================================');

scanProject('backend', 'Backend');
scanProject('frontend', 'Frontend');

console.log('\n==========================================');
console.log('Scan complete!');
console.log('==========================================\n');

console.log('Common fixes:');
console.log('1. For @ aliases: Configure in tsconfig.json or vite.config.js');
console.log('2. For missing extensions: Add .js or .ts to relative imports');
console.log('3. For ESM projects: Use "type": "module" in package.json');
console.log('');
