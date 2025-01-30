#!/bin/bash

# Source and destination directories for the copy
DEST_DIR_RECOIL="/home/recoil/shared_space/RECOIL_Data_Repo/"
DEST_DIR_JOSE="/home/jose/RECOIL_Data_Repo/"

# Step 1: Change ownership of all files in RECOIL_Data_Repo to the current user
chown -R $(whoami):$(whoami) "$DEST_DIR_RECOIL"

# Step 2: Copy all files from RECOIL_Data_Repo to jose's RECOIL_Data_Repo
rsync -avh --progress "$DEST_DIR_RECOIL" "$DEST_DIR_JOSE"

# Step 3: Change ownership of all files in jose's RECOIL_Data_Repo to the current user
chown -R $(whoami):$(whoami) "$DEST_DIR_JOSE"

# Step 4: Navigate to the destination directory
cd "$DEST_DIR_JOSE" || { echo "Failed to navigate to $DEST_DIR_JOSE"; exit 1; }

# Step 5: Add all files to git, commit, and push with force
git add .
git commit -m "update"
git push --force

# Output result message
echo "Files copied from $DEST_DIR_RECOIL to $DEST_DIR_JOSE, ownership changed to $(whoami), and git updated with forced push."

