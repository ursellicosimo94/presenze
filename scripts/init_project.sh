#!/bin/bash

cd "$(dirname "$0")/.."

if [ ! -d "frontend" ]; then
    git clone git@github.com:ursellicosimo94/presenze-frontend.git frontend
fi

if [ ! -d "backend" ]; then
    git clone git@github.com:ursellicosimo94/presenze-backend.git backend
fi