#!/bin/bash

ENV_FILE="srcs/confidential/.env"


if [ "$(uname)" == "Darwin" ]; then
    # macOS
    BASE_DIR="/Users/$USER/data"
else
    # Linux
    BASE_DIR="/home/$USER/data"
fi

if ! grep -q "DATA_PATH=" srcs/.env; then
	if [ -s $ENV_FILE ] && [ "$(tail -c 1 $ENV_FILE | wc -l)" -eq 0 ]; then
    echo "" >> $ENV_FILE
	fi
    echo "DATA_PATH=$BASE_DIR" >> $ENV_FILE
fi

if [ "$2" == "--delete" ]; then
    echo "Deleting volume..."
    rm -rf "$BASE_DIR"
    rm -rf "$BASE_DIR"
    echo "Delete COMPLETE!!!"

    if [ -f "$ENV_FILE" ]; then
        sed -i '' '/^DATA_PATH=/d' "$ENV_FILE"
    else
        echo ".env file not found. Skipping DATA_PATH removal."
    fi
    exit 0
fi

if [ ! -d "$BASE_DIR" ]; then
    echo "Making directory..."
	mkdir -p $BASE_DIR/databases/
    echo "MAKE COMPLETE!!!"
fi
