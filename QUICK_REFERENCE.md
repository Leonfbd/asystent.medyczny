# Quick Reference Guide

## 📁 Project Ready!

Your repository is now prepared to receive backend and frontend code.

## 🚀 Quick Start (After Uploading Code)

### One-Command Setup
```bash
./complete-setup.sh
```

### Start Development
```bash
# Terminal 1 - Backend
cd backend
npm run dev

# Terminal 2 - Frontend  
cd frontend
npm run dev
```

## 📋 What's Been Set Up

### ✅ Directory Structure
```
asystent.medyczny/
├── backend/              # Your backend code goes here
│   ├── src/              # Source files
│   ├── config/           # Configurations
│   ├── package.json      # Dependencies
│   └── .env.example      # Environment template
│
├── frontend/             # Your frontend code goes here
│   ├── src/              # Source files
│   ├── public/           # Static assets
│   ├── package.json      # Dependencies
│   └── .env.example      # Environment template
│
└── [Helper Scripts]      # Automation tools
```

### ✅ Automation Tools

| Script | Purpose | When to Use |
|--------|---------|-------------|
| `complete-setup.sh` | Full automated setup | After uploading code |
| `setup.sh` | Check structure & install deps | Quick verification |
| `install-deps.sh` | Install npm packages | Manual dependency install |
| `fix-config.js` | Auto-fix package.json | Configuration issues |
| `check-imports.js` | Scan import paths | Import/path errors |
| `diagnose.sh` | Troubleshooting | Debugging problems |

### ✅ Configuration Files

- **`.gitignore`** - Excludes node_modules, .env, build files
- **`.env.example`** - Environment variable templates (backend & frontend)
- **`package.json`** - Pre-configured for both apps
- **Templates** - Framework-specific config templates

## 📝 Upload Your Code

### Backend
1. Place your backend files in `backend/`
2. Main entry should be `src/index.js` or `src/server.js`
3. Update `package.json` dependencies if needed

### Frontend  
1. Place your frontend files in `frontend/`
2. Source files in `src/`, assets in `public/`
3. Update `package.json` dependencies if needed

## 🔧 After Upload

1. **Run setup**: `./complete-setup.sh`
2. **Configure .env files**: Edit `backend/.env` and `frontend/.env`
3. **Start servers**: Both with `npm run dev`

## ❓ Troubleshooting

### Problem: Setup script fails
**Solution**: Run `./diagnose.sh` to see detailed diagnostics

### Problem: Dependencies won't install
**Solution**: 
- Check `package.json` is valid JSON
- Run `npm install` manually in each directory
- Check Node.js version (requires 18.x+)

### Problem: Import errors
**Solution**: Run `node check-imports.js` to detect issues

### Problem: Scripts don't work
**Solution**: Run `node fix-config.js` to auto-fix

### Problem: Port already in use
**Solution**: 
- Check `.env` and change PORT
- Or stop other processes using port 3000/5173

## 📚 Documentation

- **`README.md`** - Main project documentation
- **`SETUP_GUIDE.md`** - Detailed setup instructions
- **`backend/README.md`** - Backend-specific info
- **`frontend/README.md`** - Frontend-specific info

## 🎯 Next Steps

1. ✅ Repository structure created
2. ✅ Automation tools ready
3. ✅ Configuration files prepared
4. ⏳ Upload your backend code
5. ⏳ Upload your frontend code
6. ⏳ Run `./complete-setup.sh`
7. ⏳ Start developing!

---

**Need help?** Check `SETUP_GUIDE.md` for comprehensive instructions.
