#!/bin/bash

srclist2paths () {
    local srclist=$1
    local base_path=$2
    local list=$3

    # Iterate through each line in the srclist file
    while IFS= read -r srcfile; do
        # Remove leading and trailing whitespace
        srcfile=$(echo "$srcfile" | xargs)

        # Ignore empty lines
        if [[ -z "$srcfile" ]]; then
            continue
        fi

        # If the line represents another .srclist file, process it recursively
        if [[ "$srcfile" =~ /srclists$ ]]; then
            local labs_path=$(dirname "$base_path")
            local folder_part=$(dirname "$srcfile")
            local file_part=$(basename "$srcfile")
            local new_base_path="${base_path%/*}/$folder_part"
            list=$(srclist2paths "$new_base_path/$file_part" "$new_base_path" "$list")
        else
            # Resolve relative paths (../) to absolute paths
            full_path=$(realpath -m "${base_path}/${srcfile}")

            # Avoid duplicate entries
            if [[ ! " ${list} " =~ " ${full_path} " ]]; then
                list="${list} ${full_path}"
            fi
        fi
    done < "$srclist"

    # Return the updated list
    echo "$list"
}

# Base directory of the script
CURRENT_DIR=$(dirname "$(realpath "$0")")

# Source files list
list=""
list=$(srclist2paths "$1" "$2" "$list")

# Return the complete list
echo "${list}"