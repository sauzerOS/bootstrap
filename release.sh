#!/bin/sh -e

# Ensure rsync is available
if ! command -v rsync >/dev/null 2>&1; then
    echo "Error: rsync not found in PATH" >&2
    exit 1
fi

REPO_PATH="/repo/bootstrap"
ARCHIVE_NAME="/tmp/bootstrap-repo.tar.xz"

# 1. Create a temporary directory.
TEMP_DIR=$(mktemp -d)

# 2. Use rsync -aL to copy all files, resolving all symlinks (-L) into actual files.
#    The trailing slash on the source is important.
rsync -aL "$REPO_PATH"/ "$TEMP_DIR/bootstrap"

# 3. Create the final archive from the clean directory.
#    -C "$TEMP_DIR" ensures the paths inside the archive start with 'bootstrap/'.
tar --create --xz --file="$ARCHIVE_NAME" -C "$TEMP_DIR" "bootstrap"

# 4. Clean up the temporary directory.
rm -rf "$TEMP_DIR"

gh release upload latest /tmp/bootstrap-repo.tar.xz --clobber
