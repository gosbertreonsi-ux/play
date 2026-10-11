#!/bin/bash

# Ensure script stops if any individual command fails
set -e

DICTIONARY_FILE="data/dictionary.txt"
LOG_FILE="activity.log"

# Verify dictionary file exists
if [ ! -f "$DICTIONARY_FILE" ]; then
    echo "Error: $DICTIONARY_FILE not found."
    exit 1
fi

# Pick a random phrase from the dictionary file
RANDOM_PHRASE=$(shuf -n 1 "$DICTIONARY_FILE")

# Append timestamp to log file
echo "Automation run: $(date -u '+%Y-%m-%d %H:%M:%S UTC') - Action: $RANDOM_PHRASE" >> "$LOG_FILE"

# Configure Git identities
git config user.name "gosbertreonsi-ux"
git config user.email "gosbertreonsi@gmail.com"

# Stage log changes
git add "$LOG_FILE"

# Commit using the picked phrase. If no changes, exit cleanly.
git commit -m "automation: $RANDOM_PHRASE" || exit 0

# Push changes securely back to GitHub
git push
