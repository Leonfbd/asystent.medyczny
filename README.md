# asystent.medyczny

Medical Assistant Application - Full Stack Project

## Project Structure

This repository is organized as a monorepo containing both backend and frontend applications:

```
asystent.medyczny/
├── backend/          # Backend application
│   ├── src/          # Source code
│   ├── config/       # Configuration files
│   └── package.json  # Backend dependencies
│
├── frontend/         # Frontend application
│   ├── src/          # Source code
│   ├── public/       # Public assets
│   └── package.json  # Frontend dependencies
│
└── README.md         # This file
```

## Getting Started

### Backend Setup

```bash
cd backend
npm install
npm run dev
```

The backend server will start in development mode.

### Frontend Setup

```bash
cd frontend
npm install
npm run dev
```

The frontend development server will start.

## Development

Both applications are configured to run with `npm run dev` for development mode.

### Prerequisites
- Node.js (recommended version: 18.x or higher)
- npm or yarn package manager

## Quick Start

After uploading your backend and frontend code:

```bash
# 1. Run the setup script to check everything
./setup.sh

# 2. Install dependencies
./install-deps.sh

# 3. Auto-fix configurations (if needed)
node fix-config.js

# 4. Check for import issues
node check-imports.js

# 5. Start developing!
```

## Helper Scripts

- **`setup.sh`** - Checks project structure and installs dependencies
- **`install-deps.sh`** - Installs npm packages for backend and frontend
- **`fix-config.js`** - Auto-fixes package.json and npm scripts
- **`check-imports.js`** - Scans for import/path issues

## Detailed Setup Guide

See [SETUP_GUIDE.md](./SETUP_GUIDE.md) for comprehensive instructions.

## Contributing

1. Upload your backend code to the `backend/` directory
2. Upload your frontend code to the `frontend/` directory
3. Run `./setup.sh` to verify and install dependencies
4. Use helper scripts to auto-fix common issues
5. Run the applications using `npm run dev`