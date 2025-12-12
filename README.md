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

## Contributing

1. Upload your backend code to the `backend/` directory
2. Upload your frontend code to the `frontend/` directory
3. Ensure all imports and paths are correctly configured
4. Install dependencies in each directory
5. Run the applications using `npm run dev`