#!/bin/bash

# Set the path to your Downloads folder
downloads_folder="$HOME/Downloads"

# Set the path to the archive folder
archive_folder="$HOME/Downloads/Archive"

# Create the archive folder if it doesn't exist
mkdir -p "$archive_folder"

# Get the current date in the format: Month_Year (e.g., Dec_2023)
current_date=$(date +"%b_%Y")

# Calculate the timestamp for one month ago
one_month_ago=$(date -d "1 month ago" +"%Y%m%d%H%M.%S")

# Find files in Downloads older than one month
declare -a files_to_archive
while IFS= read -r -d '' file; do
    files_to_archive+=("$file")
done < <(find "$downloads_folder" -type f -mtime +30 -print0)

#Create a tar archive with the files
if [  ${#files_to_archive[@]} -gt 0  ]; then
    archive_filename="$archive_folder/archive_$current_date.tar.gz"
     tar -czf "$archive_filename" "${files_to_archive[@]}"
    
    # Remove the files from Downloads
    rm "${files_to_archive[@]}"
    
    echo "Files older than one month archived to: $archive_filename"
else
    echo "No files older than one month found in Downloads folder."
fi
