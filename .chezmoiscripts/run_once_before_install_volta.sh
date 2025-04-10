#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if Volta is already installed
if ! command -v volta &> /dev/null; then
    echo "Volta not found. Installing Volta..."

    # Download and install Volta
    curl https://get.volta.sh | bash
else
    echo "Volta is already installed."
fi
