#!/bin/bash

# Prompt the user for the directory
read -p "Enter the directory please: " folderPath

# Check if the provided input is a folder or not
if [ -d "$folderPath" ]; then
    cd "$folderPath"

    # Loop over all the directory contents and create the folders
    for item in *.*; do
        if [ -f "$item" ]; then
            # Extract the full extension including the last period
            full_extension=".${item##*.}"
            # Get the filename without its full extension (everything before the last period)
            filenameWithoutExtension="${item%.*}"
            # Replace all periods in the filename with spaces
            newFilenameWithoutExtension="${filenameWithoutExtension//./ }"
            # Rebuild the filename with the original extension
            newname="${newFilenameWithoutExtension}${full_extension}"

            # Check if the new name differs from the original name and rename if necessary
            if [[ "$item" != "$newname" ]]; then
                echo "Renaming '$item' to '$newname'"
                mv "$item" "$newname"
                item="$newname"  # Update the item variable to reflect the new name for folder creation
            fi

            # Split the filename to remove the extension for folder naming
            base_name="${newFilenameWithoutExtension}"

            # Check if a folder with the filename already exists, if not, create it
            if [ ! -d "$base_name" ]; then
                mkdir "$base_name"
            fi

            # Move the file into the newly created directory
            mv "$item" "$base_name/"
        fi
    done
else
    echo "The path you provided is not a directory"
fi
