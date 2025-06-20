#!/bin/bash

function display_usage {
    echo "Usage: ./backup.sh <path to your source> <backup folder path>"
}

# Check if arguments are passed
if [ $# -eq 0 ]; then
    display_usage
    exit 1
fi

source_dir=$1
timestamp=$(date '+%Y-%m-%d_%H-%M-%S')
backup_dir=$2

# Check if source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Error: Source directory '$source_dir' does not exist."
    exit 1
fi

# Function to create a zip backup of the source directory
function create_backup {
    zip_file="${backup_dir}/backups_${timestamp}.zip"
    zip -r "$zip_file" "$source_dir"
    echo "Backup complete for ${timestamp}"

  # Upload entire backup directory to S3 using sync
    aws s3 sync "$backup_dir" s3://bucket_name
    echo "Sync to S3 complete."
}

# Function to keep only the latest 5 backups (delete older folder/files)
function perform_rotation {
    backups=($(ls -t "${backup_dir}/backups_"*.zip 2>/dev/null))

    if [ "${#backups[@]}" -gt 5 ]; then
        echo "Performing rotation for 5 days"

        backup_to_remove=("${backups[@]:5}")
        echo "${backup_to_remove[@]}"
                    for file in "${backup_to_remove[@]}"; do
            rm -f "$file"
            echo "Deleted: $file"
        done
    fi
}


create_backup
perform_rotation    
