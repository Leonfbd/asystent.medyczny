# Project Setup Guide

This guide helps you upload and configure your backend and frontend code.

## Directory Structure

```
asystent.medyczny/
├── backend/           # Place your backend code here
│   ├── src/           # Backend source files
│   ├── config/        # Configuration files
│   ├── package.json   # Dependencies
│   └── .env.example   # Environment variables template
│
├── frontend/          # Place your frontend code here
│   ├── src/           # Frontend source files
│   ├── public/        # Static assets
│   ├── package.json   # Dependencies
│   └── .env.example   # Environment variables template
│
├── setup.sh           # Automated setup script
└── fix-config.js      # Configuration auto-fixer
```

## Step-by-Step Setup

### 1. Upload Your Code

**Backend:**
- Copy all your backend files to the `backend/` directory
- Ensure your main entry point is one of:
  - `src/index.js`
  - `src/server.js`
  - `src/app.js`

**Frontend:**
- Copy all your frontend files to the `frontend/` directory
- Ensure your source files are in `src/`
- Place static assets in `public/`

### 2. Run Setup Script

```bash
./setup.sh
```

This script will:
- Detect your framework automatically
- Install dependencies for both backend and frontend
- Verify the project structure

### 3. Auto-Fix Configurations (if needed)

If you encounter configuration issues:

```bash
node fix-config.js
```

This will automatically:
- Detect your entry points
- Configure npm scripts
- Fix common path issues
- Ensure `npm run dev` works correctly

### 4. Configure Environment Variables

**Backend:**
```bash
cd backend
cp .env.example .env
# Edit .env with your actual values
```

**Frontend:**
```bash
cd frontend
cp .env.example .env
# Edit .env with your actual values
```

### 5. Start Development Servers

**Backend:**
```bash
cd backend
npm run dev
```

**Frontend (in a new terminal):**
```bash
cd frontend
npm run dev
```

## Common Frameworks Supported

### Backend
- Express.js
- Fastify
- NestJS
- Plain Node.js

### Frontend
- React (with Vite or Create React App)
- Vue.js (with Vite)
- Next.js
- Plain HTML/JS

## Troubleshooting

### Backend won't start?
1. Check that your entry point exists in `src/`
2. Verify all dependencies are in `package.json`
3. Run `npm install` again
4. Check for missing environment variables

### Frontend won't start?
1. Ensure `package.json` has the correct dev script
2. For Vite projects, ensure `vite.config.js` exists
3. For React, check that React and ReactDOM are installed
4. Run `npm install` again

### Import/Path Issues?
- Ensure all relative imports use correct paths
- For absolute imports, check if you need to configure path aliases
- The `fix-config.js` script can help detect some issues

## Port Configuration

Default ports (can be changed in .env):
- Backend: 3000
- Frontend: 5173 (Vite) or 3000 (CRA)

If ports conflict, update them in:
- Backend: `.env` file (PORT variable)
- Frontend: Vite uses `vite.config.js`, CRA uses PORT env var

## Need Help?

1. Check README.md in backend/ and frontend/ directories
2. Run the setup script: `./setup.sh`
3. Run the config fixer: `node fix-config.js`
4. Check console output for specific error messages
