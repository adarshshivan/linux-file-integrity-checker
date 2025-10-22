#!/bin/bash
# ================================
# 🧩 Linux File Integrity Checker
# Author: Adarsh Shivan
# ================================

# Directory to monitor
TARGET_DIR="/home/adarsh/linux-projects/linux-file-integrity-checker/test_files"

# Files storing old and new hashes
HASH_FILE="hashes.log"
NEW_HASH_FILE="new_hashes.log"

# Create target directory if not exists
mkdir -p "$TARGET_DIR"

# Function to generate initial hashes
generate_hashes() {
    echo "🔐 Generating initial file hashes..."
    find "$TARGET_DIR" -type f -exec sha256sum {} \; > "$HASH_FILE"
    echo "✅ Hashes saved to $HASH_FILE"
}

# Function to verify file integrity
verify_hashes() {
    echo "🔎 Verifying file integrity..."
    find "$TARGET_DIR" -type f -exec sha256sum {} \; > "$NEW_HASH_FILE"

    echo "🧾 Comparing with previous hashes..."
    diff "$HASH_FILE" "$NEW_HASH_FILE" > integrity_diff.log

    if [ -s integrity_diff.log ]; then
        echo "⚠️ Changes detected! See integrity_diff.log for details."
    else
        echo "✅ No changes detected. Files are intact."
    fi
}

# Menu
echo "==============================="
echo "  🧠 Linux File Integrity Checker"
echo "==============================="
echo "1️⃣ Generate Hashes"
echo "2️⃣ Verify Integrity"
echo "3️⃣ Exit"
echo "==============================="
read -p "Enter your choice: " choice

case $choice in
    1) generate_hashes ;;
    2) verify_hashes ;;
    3) echo "👋 Exiting..."; exit 0 ;;
    *) echo "❌ Invalid option" ;;
esac

