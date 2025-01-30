#!/bin/bash

# Source and destination directories for the copy
DEST_DIR_RECOIL="/home/recoil/shared_space/RECOIL_Data_Repo/"

# Assume you have one under your folder
DEST_DIR_USER="/home/$(whoami)/RECOIL_Data_Repo/"

# Check if DEST_DIR_USER exists; if not, create it
if [ ! -d "$DEST_DIR_USER" ]; then
  mkdir -p "$DEST_DIR_USER"
  echo "Created destination directory: $DEST_DIR_USER"
fi

# Step 1: Change ownership of all files in RECOIL_Data_Repo to the current user
chown -R "$(whoami):$(whoami)" "$DEST_DIR_RECOIL"

# Step 2: Copy all files from RECOIL_Data_Repo to the user's RECOIL_Data_Repo
rsync -avh --progress "$DEST_DIR_RECOIL" "$DEST_DIR_USER"

# Step 3: Change ownership of all files in user's RECOIL_Data_Repo to the current user
chown -R "$(whoami):$(whoami)" "$DEST_DIR_USER"

# Step 4: Navigate to the destination directory
cd "$DEST_DIR_USER" || { echo "Failed to navigate to $DEST_DIR_USER"; exit 1; }

# Get the current date and time
CURRENT_DATETIME=$(date '+%Y-%m-%d %H:%M:%S')

# Step 5: Add all files to git, commit, and push with force
git add .
git commit -m "Update RECOIL data repo - $CURRENT_DATETIME"
git push --force

# Output result message
echo "Files copied from $DEST_DIR_RECOIL to $DEST_DIR_USER, ownership changed to $(whoami), and git updated and pushed to main."
