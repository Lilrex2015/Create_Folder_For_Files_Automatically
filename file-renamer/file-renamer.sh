#!/bin/bash

# Prompt the user for the directory
read -p "Enter the directory path: " dirPath

# Check if the provided path is a directory
if [[ -d "$dirPath" ]]; then
    # Navigate to the directory
    cd "$dirPath"

    # Loop through all files in the directory
    for file in *.*; do
        if [[ -f "$file" ]]; then
            # Extract the extension including the last period
            extension=".${file##*.}"
            # Get the filename without its full extension (everything before the last period)
            filenameWithoutExtension="${file%.*}"
            # Replace all periods in the filename with spaces
            newFilenameWithoutExtension="${filenameWithoutExtension//./ }"
            # Rebuild the filename with the original extension
            newname="${newFilenameWithoutExtension}${extension}"

            # Check if the new name differs from the original name
            if [[ "$file" != "$newname" ]]; then
                echo "Renaming '$file' to '$newname'"
                # Rename the file
                mv "$file" "$newname"
            fi
        fi
    done
else
    echo "The provided path is not a directory."
fi
