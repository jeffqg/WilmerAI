#!/bin/bash

# Ensure Unix line endings
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' 's/\r$//' "$0"
else
    # Linux and others (not needed for macOS specific script)
    sed -i 's/\r$//' "$0"
fi

echo "Creating virtual environment..."
python3 -m venv venv
if [ $? -ne 0 ]; then
    echo "Failed to create virtual environment."
    exit 1
fi
echo "Virtual environment created successfully."

echo "Activating virtual environment..."
source venv/bin/activate
if [ $? -ne 0 ]; then
    echo "Failed to activate virtual environment."
    exit 1
fi
echo "Virtual environment activated."

echo "Installing dependencies from requirements.txt..."
pip install -r requirements.txt
if [ $? -ne 0 ]; then
    echo "Failed to install dependencies."
    exit 1
fi
echo "Dependencies installed successfully."

echo "Starting the application..."
python3 server.py "$@"
if [ $? -ne 0 ]; then
    echo "Failed to start the application."
    exit 1
fi
echo "Application started successfully."