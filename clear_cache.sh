#!/bin/bash

echo "--- Cache Clearing Script Started: $(date) ---"

# 1. Clear PageCache, dentries, and inodes
# This is generally safe and effective for freeing up memory.
# 'sync' flushes the filesystem buffers.
# '/proc/sys/vm/drop_caches' is the kernel interface for dropping caches.


echo "Clearing PageCache, dentries, and inodes..."
sync
sudo sysctl -w vm.drop_caches=3


# Explanation of vm.drop_caches values:
# 1: Frees pagecache
# 2: Frees dentries and inodes
# 3: Frees pagecache, dentries, and inodes (most common for full cache clear)

# Check if the previous command was successful

if [ $? -eq 0 ]; then
    echo "PageCache, dentries, and inodes cleared successfully."
else
    echo "Error: Failed to clear PageCache, dentries, and inodes."
fi

# 2. Clear APT cache (package manager cache)
# This removes downloaded package files that are no longer needed.
echo "Cleaning APT cache..."


sudo apt clean
if [ $? -eq 0 ]; then
    echo "APT cache cleared successfully."
else
    echo "Error: Failed to clear APT cache."
fi

# 3. Clear Thumbnail Cache (for user's home directory)
# This can reclaim significant space if you have many images.
# This part runs as the user who executes the cron job.


echo "Clearing user's thumbnail cache..."
rm -rf ~/.cache/thumbnails/*
if [ $? -eq 0 ]; then
    echo "User's thumbnail cache cleared successfully."
else
    echo "Error: Failed to clear user's thumbnail cache. (Might not exist or permissions issue)"
fi

# 4. Clear Journald Logs (optional - use with caution)
# Journald logs can grow quite large. This truncates them to a certain size or time.
# Choose one of the following commands based on your preference:
# To limit by size (e.g., 50MB): sudo journalctl --vacuum-size=50M
# To limit by time (e.g., 7 days): sudo journalctl --vacuum-time=7d
# For this script, we'll just report the current usage, and you can uncomment one if needed.

echo "Current Journald log usage:"
sudo journalctl --disk-usage

# If you want to clear older journald logs, uncomment and modify one of the following lines:
# echo "Truncating Journald logs to last 7 days..."
# sudo journalctl --vacuum-time=7d
# if [ $? -eq 0 ]; then
#     echo "Journald logs truncated successfully."
# else
#     echo "Error: Failed to truncate Journald logs."
# fi

# 5. Clear application-specific caches (examples - uncomment if needed)
# Firefox cache (example):
# echo "Clearing Firefox cache..."
# rm -rf ~/.cache/mozilla/firefox/*.default*/cache2/*
# Chrome/Chromium cache (example):
# echo "Clearing Chrome/Chromium cache..."
# rm -rf ~/.cache/google-chrome/Default/Cache/*
# rm -rf ~/.cache/chromium/Default/Cache/*

echo "--- Cache Clearing Script Finished: $(date) ---"
echo "Check 'free -h' to see memory changes."
