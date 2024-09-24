#!/bin/bash

ENV_FILE="srcs/confidential/.env"


if [ "$(uname)" == "Darwin" ]; then
    # macOS
    DATA_PATH="/Users/$USER/data"
else
    # Linux
    DATA_PATH="/home/$USER/data"
fi

if ! grep -q "DATA_PATH=" $ENV_FILE; then
	if [ -s $ENV_FILE ] && [ "$(tail -c 1 $ENV_FILE | wc -l)" -eq 0 ]; then
    echo "" >> $ENV_FILE
	fi
    echo "DATA_PATH=$DATA_PATH" >> $ENV_FILE
fi

if [ "$1" == "--delete" ]; then
    echo "Deleting volume..."
    rm -rf "$DATA_PATH"
    rm -rf "$DATA_PATH"
    echo "Delete COMPLETE!!!"

    if [ -f "$ENV_FILE" ]; then
        sed -i '' '/^DATA_PATH=/d' "$ENV_FILE"
    else
        echo ".env file not found. Skipping DATA_PATH removal."
    fi
    exit 0
fi

if [ ! -d "$DATA_PATH" ]; then
    echo "Creating directory..."
	mkdir -p $DATA_PATH
    echo "Volume directory created!!!"
fi
