gdl() {
    # Gallery-dl download and zip function
    # Usage: gdl <gallery_url>
    
    # Check if URL is provided
    if [ $# -eq 0 ]; then
        echo "Usage: gdl <gallery_url>"
        echo "Example: gdl https://example.com/gallery/123"
        return 1
    fi

    GALLERY_URL="$1"

    # Create a temporary directory for downloads
    TEMP_DIR=$(mktemp -d)
    echo "Created temporary directory: $TEMP_DIR"

    # Cleanup function
    cleanup() {
        echo "Cleaning up temporary directory..."
        rm -rf "$TEMP_DIR"
    }

    # Always set RETURN trap to ensure temporary directory is removed when the
    # function returns. If you want to keep the temp dir for debugging, do not
    # call this function or create the tempdir manually.
    trap cleanup RETURN

    # Store current directory
    ORIGINAL_DIR=$(pwd)

    # Change to temp directory
    cd "$TEMP_DIR"

    echo "Downloading gallery from: $GALLERY_URL"

    # Download the gallery with sleep settings to avoid throttling
    gallery-dl \
        --sleep 2-5 \
        --sleep-request 2-5 \
        "$GALLERY_URL"

    # Find the innermost directory that contains files (handles nested gallery-dl structure).
    # This method computes directory depth and selects the deepest dirname containing a file.
    INNERMOST_DIR=$(find . -type f -exec dirname {} \; 2>/dev/null | awk -F'/' '{print NF, $0}' | sort -n | tail -n1 | cut -d' ' -f2-)

    if [ -n "$INNERMOST_DIR" ] && [ "$INNERMOST_DIR" != "." ]; then
        # Get the gallery name from the innermost directory
        GALLERY_NAME=$(basename "$INNERMOST_DIR")
        echo "Found gallery in nested structure: $GALLERY_NAME"

        # Move files safely from the innermost directory to temporary directory root.
        # Avoid shell globbing (zsh will error on unmatched globs) and handle spaces/newlines in names.
        echo "Moving files from nested structure to temporary directory root..."
        find "$INNERMOST_DIR" -mindepth 1 -maxdepth 1 -print0 2>/dev/null | xargs -0 -I{} mv "{}" . 2>/dev/null || true

        # Clean up the now-empty nested directory structure
        rm -rf gallery-dl 2>/dev/null || true
    else
        # Fallback: unexpected directory structure
        # Inform the user, then allow the normal RETURN trap to run (if enabled)
        echo "Warning: Could not automatically detect gallery structure."
        echo "Downloaded files are in: $TEMP_DIR"
        echo "Please navigate to the directory and handle the files manually."
    echo "Temporary directory will be cleaned up automatically." 

        # Return to original directory; do NOT unset the RETURN trap so cleanup runs
        cd "$ORIGINAL_DIR"
        return 1
    fi

    # Create the final zip file path in the original working directory
    ZIP_FILE="$ORIGINAL_DIR/${GALLERY_NAME}.zip"

    echo "Creating zip file: $ZIP_FILE"

    # Since files are now at root level, we can zip them directly
    if [ "$(find . -maxdepth 1 -type f | wc -l)" -gt 0 ]; then
        zip -r "$ZIP_FILE" ./* 2>/dev/null
        echo "Successfully created: $ZIP_FILE"
        echo "Contains $(find . -maxdepth 1 -type f | wc -l) files"
    else
        echo "Error: No files found to zip"
        # Let the RETURN trap perform cleanup if enabled
        cd "$ORIGINAL_DIR"
        return 1
    fi

    # Return to original directory; the RETURN trap will handle cleanup
    cd "$ORIGINAL_DIR"
}