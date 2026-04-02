#!/usr/bin/env bash
#
# Power Management Defaults
#
# These settings require sudo and cannot be applied via macos-defaults.
# Run manually: sudo bash defaults/power.sh
#
# Reference: man pmset
#

set -e

echo "Applying power management settings..."

# Wake when opening the lid
sudo pmset -a lidwake 1

# Auto-restart on power loss
sudo pmset -a autorestart 1

# Display sleep after 15 minutes
sudo pmset -a displaysleep 15

# No machine sleep when plugged in
sudo pmset -c sleep 0

echo "Power management settings applied."
echo "Run 'pmset -g' to verify."
