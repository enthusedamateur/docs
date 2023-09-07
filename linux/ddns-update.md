#!/bin/bash

# Define the path to the configuration file
config_file=~/.cloudflare-ddns

# Define the path to the log file
log_file=~/cloudflare-ddns-client/log

# Function to log messages
log() {
  local timestamp
  timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  echo "[$timestamp] $1" >> "$log_file"
}

log " "

# Function to handle errors and exit
handle_error() {
  local message="$1"
  log "ERROR: $message"
  echo "$message"
  exit 1
}

# Function to get the current external IP address
get_external_ip() {
  # If an IP address argument is provided, use it
  if [ -n "$1" ]; then
    echo "$1"
  else
    # Otherwise, retrieve the actual external IP address
    curl -s4 http://icanhazip.com
  fi
}

# Check if the file exists
if [ ! -f "$config_file" ]; then
  handle_error "Config file $config_file not found."
fi

# Extract the 'domains' variable from the config file
domains_line=$(grep 'domains =' "$config_file")

# Check if 'domains' is present in the config file
if [ -z "$domains_line" ]; then
  handle_error "No 'domains' variable found in the config file."
fi

# Extract the VPN address from the 'domains' variable without output
vpn_address=$(echo "$domains_line" | awk -F'= ' '{print $2}' | awk -F',' '{print $1}' | grep -o 'vpn\..*' 2>/dev/null)

# Check if a VPN address was found
if [ -z "$vpn_address" ]; then
  handle_error "No VPN address found in the 'domains' variable."
fi

# Query the IPv4 address of the VPN URL
ipv4_address=$(dig +short "$vpn_address" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}')

# Check if an IPv4 address was found
if [ -z "$ipv4_address" ]; then
  handle_error "Unable to resolve the IPv4 address for $vpn_address."
fi

# Log the extracted VPN address and its IPv4 address
log "VPN Address: $vpn_address"
log "IPv4 Address: $ipv4_address"

# Get the current WAN IP address, with optional testing IP argument
log "Getting current WAN IP address..."
current_ip=$(get_external_ip "$1")

# Check if the IP addresses differ
if [ "$current_ip" != "$ipv4_address" ]; then
  # Message shown if the update is about to run
  log "IP has changed!"
  log "Updating A records..."

  # Update the Cloudflare DDNS record
  log "Updating Cloudflare DDNS record..."
  cloudflare-ddns --update-now >> "$log_file" 2>&1
else
  # Output message if IPs match
  log "IP address has not changed."
fi

log " "
