#!/bin/bash

# Script for updating Teleport Proxy
# Author: Philipp Zimmermann
# Date: 07.01.2024

#!/bin/bash

# VARS
RELEASE_PAGE="https://github.com/gravitational/teleport/releases"
EDITION="oss"
UPDATE_COMMAND="curl https://cdn.teleport.dev/install-__VERSION__.sh | bash -s __VERSION_WITHOUT_V__ __EDITION__"

# Function to compare versions
version_gt() {
    # Returns true if $1 is greater than $2
    [ "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1" ]
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -e|--edition)
            if [[ "$2" =~ ^(oss|cloud|enterprise)$ ]]; then
                EDITION="$2"
                shift # Shift past argument value
            else
                echo "Invalid edition specified. Allowed values are: oss, cloud, enterprise."
                exit 1
            fi
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
    shift # Shift past argument
done

# Get all versions from Github release page
versions=$(curl -s "$RELEASE_PAGE" \
    | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' \
    | grep -w 'v[0-9]\+\.[0-9]\+\.[0-9]\+' \
    | sort -u)

# Get the latest release (highest version)
latest_release=$(echo "$versions" | sort -V | tail -n 1)

# Remove the 'v' prefix from the version for the second substitution
version_no_v=${latest_release#v}

# Print the latest release to verify
echo "Found Latest Release: $latest_release"

# Get the currently installed version
current_version=$(teleport version 2>/dev/null | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' | sort -u)
if [ -z "$current_version" ]; then
    echo "Teleport is not installed or not in PATH. Proceeding with installation."
    current_version="v0.0.0" # Treat as if no version is installed
else
    echo "Currently Installed Version: $current_version"
fi

# Compare versions and update if needed
if version_gt "$latest_release" "$current_version"; then
    echo "A newer version is available: $latest_release (Installed: $current_version)"
    update_command_with_values=${UPDATE_COMMAND/__VERSION__/$latest_release}
    update_command_with_values=${update_command_with_values/__VERSION_WITHOUT_V__/$version_no_v}
    update_command_with_values=${update_command_with_values/__EDITION__/$EDITION}

    # Print the final update command
    echo "Executing: $update_command_with_values"
    eval "$update_command_with_values"
else
    echo "Teleport is already up-to-date (Installed: $current_version, Latest: $latest_release)"
fi