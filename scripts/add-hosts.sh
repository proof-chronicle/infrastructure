#!/usr/bin/env bash
# Script to add new hosts to /etc/hosts

set -euo pipefail
IFS=$'\n\t'

HOSTS_FILE="/etc/hosts"
BACKUP_FILE="/etc/hosts.bak.$(date +%Y%m%d%H%M%S)"

usage() {
    cat <<EOF
Usage: $0 <IP_ADDRESS> <HOSTNAME>

Adds an entry to $HOSTS_FILE if it does not already exist.
Example:
  sudo $0 127.0.0.1 proofchronicle.local
EOF
    exit 1
}

# Ensure we have exactly two arguments
if [[ $# -ne 2 ]]; then
    echo "Error: Invalid number of arguments." >&2
    usage
fi

IP_ADDRESS="$1"
HOSTNAME="$2"

# Ensure script runs as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Use sudo." >&2
    exit 1
fi

# Backup hosts file
cp "$HOSTS_FILE" "$BACKUP_FILE"
echo "Backup of $HOSTS_FILE saved to $BACKUP_FILE"

# Check if the exact mapping already exists
if grep -E -q "^${IP_ADDRESS}[[:space:]]+${HOSTNAME}([[:space:]]|$)" "$HOSTS_FILE"; then
    echo "Entry for ${HOSTNAME} with IP ${IP_ADDRESS} already exists in $HOSTS_FILE."
else
    # Append the new entry
    echo -e "${IP_ADDRESS}\t${HOSTNAME}" >> "$HOSTS_FILE"
    echo "Added '${HOSTNAME} -> ${IP_ADDRESS}' to $HOSTS_FILE."
fi
