#!/bin/bash

# Define the log location and file name
log_location="/home/michael/backups"
log_file="$(date +"%Y-%m-%d-%H-%M-%S").log"

# Logging function
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S.%6N") - $1" >> "${log_location}/${log_file}"
}

# Redirect output to the log file
exec >> "${log_location}/${log_file}" 2>&1

# Log script start
log "Script started"


# Check if NFS share is mounted
if ! mountpoint -q /mnt/backup; then
    log "NFS share is not mounted. Exiting..."
    log "Script aborted at $(date)"
    exit 1
fi

# Log NFS mount
log "NFS mounted"

# Define the backup directories
backup_dirs="/home /etc /var/lib/docker /var/lib/mysql /var/www /var/log /root"

# Log dirs defined
log "Defined dirs for backup - $backup_dirs"

# Define the backup location and folder names
backup_location="/mnt/backup"
backup_folder="$(date +"%Y-%m-%d-%H-%M-%S")"
previous_backup_folder=$(ls -1 "${backup_location}" | grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{2}$' | sort -r | head -n 1)


# Check for the existence of the primary backup
primary_backup_folder="primary-backup"

# Log checking for primary backup folder
log "Checking for primary backup folder..."

if [[ ! -d "${backup_location}/${primary_backup_folder}" ]]; then

    # Log starting primary backup
    log "Primary backup not found. Creating new primary backup."

    # Create the primary backup (standalone copy)
    rsync -avz ${backup_dirs} "${backup_location}/${primary_backup_folder}" > /dev/null 2>&1

    # Log primary complete
    log "Primary backup complete."
	log "Script complete."
	exit 0
fi

# Create the backup folder
mkdir -p "${backup_location}/${backup_folder}" || { log "Failed to create backup folder. Exiting..."; log "Script aborted at $(date)"; exit 1; }

# Log start of backup process
log "Backup started at $(date)"
log "New backup started at ${backup_location}/${backup_folder}"

# Use rsync to perform incremental backup
rsync -avz --delete --link-dest="${backup_location}/${previous_backup_folder}" ${backup_dirs} "${backup_location}/${backup_folder}" > /dev/null 2>&1

# Log completion of backup process
log "Backup completed at $(date)"

# Function to trim older log files
trim_old_logs() {
    cd "${log_location}" && ls -1d *.log | sort -r | awk 'NR>10' | xargs -d '\n' rm -rf --
}

# Log trimming logs started
log "Trimming logfiles at $(date)"

# Trim older log files
trim_old_logs

# Log trimming backups started
log "Trimming older backups at $(date)"

# Trim backups other than primary and the last three
cd "${backup_location}" && ls -1d */ | grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{2}$' | grep -vE "${primary_backup_folder}" | sort -r | awk 'NR>3' | xargs -d '\n' rm -rf --

# Log script end
log "Script ended"

exit 0
