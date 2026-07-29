#!/bin/bash

set -e

echo "================================="
echo " Project Architecture Designer"
echo "================================="

read -p "Project name: " PROJECT_NAME

echo ""
echo "Choose project type:"
echo "1) Rust Axum Backend"
echo "2) Rust Ratatui TUI"
echo "3) Next.js Web App"
echo "4) Full Stack (Axum + Next.js)"

read -p "Choice: " TYPE


mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME"


case $TYPE in

1)
    echo "Creating Axum backend..."

    cargo init --bin

    mkdir -p src/{app,config,database,models,features,middleware,utils}

    mkdir -p src/features/{users,auth,lastfm}

    mkdir -p src/database/repositories


    cat > README.md <<EOF
# $PROJECT_NAME

Rust Axum Backend

Architecture:
- Feature based
- Service layer
- Repository pattern
EOF


    cat > .env <<EOF
DATABASE_URL=sqlite://database.db
EOF


    echo "Created Axum project"
;;


2)
    echo "Creating Ratatui TUI..."

    cargo init --bin

    mkdir -p src/{app,ui,components,events,models,services}


    cat > README.md <<EOF
# $PROJECT_NAME

Rust Terminal UI

Stack:
- Ratatui
- Crossterm
EOF


    cargo add ratatui
    cargo add crossterm
    cargo add tokio --features full


    echo "Created TUI project"
;;


3)
    echo "Creating Next.js app..."

    npx create-next-app@latest . \
    --typescript \
    --tailwind \
    --eslint \
    --app


    mkdir -p src/{components,features,services,hooks,types,utils}


    echo "Created Next.js project"
;;


4)
    echo "Creating Full Stack..."

    mkdir backend frontend


    cd backend

    cargo init --bin

    mkdir -p src/{app,database,models,features}


    cd ../frontend

    npx create-next-app@latest . \
    --typescript \
    --tailwind \
    --eslint \
    --app


    cd ..

    cat > README.md <<EOF
# $PROJECT_NAME

Full Stack Application

Backend:
- Rust Axum

Frontend:
- Next.js
EOF


    echo "Created Full Stack project"
;;

*)
    echo "Invalid option"
    exit 1
;;

esac


echo ""
echo "================================="
echo " Project created successfully"
echo " Location: $(pwd)"
echo "================================="
