#!/bin/bash
SOURCE_FILE="/path/to/your/source_file.txt"
DESTINATION_DIR="/path/to/your/destination_folder/"

echo "--- File Copy Script Started: $(date) ---"
echo "Source File: $SOURCE_FILE"
echo "Destination Directory: $DESTINATION_DIR"

# Check if the source file exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: Source file '$SOURCE_FILE' does not exist. Aborting."
    exit 1 # Exit with an error code
fi

# Check if the destination directory exists
if [ ! -d "$DESTINATION_DIR" ]; then
    echo "Error: Destination directory '$DESTINATION_DIR' does not exist. Aborting."
    exit 1 # Exit with an error code
fi

# Perform the copy operation
echo "Attempting to copy '$SOURCE_FILE' to '$DESTINATION_DIR'..."
cp -v -p "$SOURCE_FILE" "$DESTINATION_DIR"

# Check the exit status of the 'cp' command
if [ $? -eq 0 ]; then
    echo "File '$SOURCE_FILE' copied successfully to '$DESTINATION_DIR'."
    # You can optionally add more checks here, e.g., verify file existence in destination
    if [ -f "$DESTINATION_DIR/$(basename "$SOURCE_FILE")" ]; then
        echo "Verification: Copied file found in destination."
    else
        echo "Warning: Copied file not found in destination after copy operation."
    fi
else
    echo "Error: Failed to copy '$SOURCE_FILE' to '$DESTINATION_DIR'."
    echo "Possible reasons: permissions, disk space, incorrect paths."
fi

echo "--- File Copy Script Finished: $(date) ---"
