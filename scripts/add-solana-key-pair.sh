#!/usr/bin/env bash
# Script to generate a Solana keypair for local development inside the container
# Generates id.json in /root/.config/solana if it does not already exist

set -euo pipefail
IFS=$'\n\t'

# Default key directory inside container
KEY_DIR="/root/.config/solana"
KEY_FILE="$KEY_DIR/id.json"

# Exit if key already exists
if [[ -e "$KEY_FILE" ]]; then
  echo "Keyfile already exists at $KEY_FILE. Exiting."
  exit 0
fi

# Ensure directory exists
mkdir -p "$KEY_DIR"

# Ensure solana-keygen is available
if ! command -v solana-keygen &> /dev/null; then
  echo "Error: solana-keygen CLI is not installed or not in PATH." >&2
  exit 1
fi

# Generate new keypair
echo "Generating new Solana keypair at $KEY_FILE"
solana-keygen new --silent --outfile "$KEY_FILE"

# Secure permissions
chmod 600 "$KEY_FILE"

echo "Key generated successfully: $KEY_FILE"
