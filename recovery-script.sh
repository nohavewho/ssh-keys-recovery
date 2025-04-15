#!/bin/bash

# This script is intended to be run in a recovery environment to restore SSH access
# It will download the SSH key from GitHub and add it to authorized_keys

# Check if we're in a recovery environment with /mnt mounted
if [ -d "/mnt" ]; then
  echo "Recovery environment detected"
  
  # Create .ssh directory if it doesn't exist
  mkdir -p /mnt/root/.ssh
  
  # Download the SSH key from GitHub
  echo "Downloading SSH key from GitHub..."
  curl -s https://raw.githubusercontent.com/nohavewho/ssh-keys-recovery/main/v.yushenko.pub > /mnt/root/.ssh/authorized_keys
  
  # Set proper permissions
  chmod 700 /mnt/root/.ssh
  chmod 600 /mnt/root/.ssh/authorized_keys
  
  echo "SSH key added successfully to /mnt/root/.ssh/authorized_keys"
  
  # Try to fix nginx if it exists
  if [ -d "/mnt/etc/nginx" ]; then
    echo "Checking nginx configuration..."
    ls -la /mnt/etc/nginx/sites-enabled/
    
    # Check nginx error log
    if [ -f "/mnt/var/log/nginx/error.log" ]; then
      echo "Last 10 lines of nginx error log:"
      tail -10 /mnt/var/log/nginx/error.log
    fi
  fi
else
  echo "Not in a recovery environment or /mnt not mounted"
  echo "This script is intended to be run from a recovery environment"
fi