#!/bin/bash

# Script for updating Teleport Proxy
# Author: Philipp Zimmermann
# Date: 07.01.2024

# VARS
RELEASE_PAGE="https://github.com/gravitational/teleport/releases"
EDITION="oss"
UPDATE_COMMAND="curl https://cdn.teleport.dev/install-__VERSION__.sh | bash -s __VERSION_WITHOUT_V__ __EDITION__"

# Get all version from Github release page
versions=$(curl -s $RELEASE_PAGE \
    | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' \
    | grep -w 'v[0-9]\+\.[0-9]\+\.[0-9]\+' \
    | sort -u)

# Get the latest release (highest version)
latest_release=$(echo "$versions" | sort -V | tail -n 1)

# Remove the 'v' prefix from the version for the second substitution
version_no_v=${latest_release#v}

# Print the latest release to verify
echo "Found Latest Release: $latest_release"

# Replace placeholders in the update command
update_command_with_values=${UPDATE_COMMAND/__VERSION__/$latest_release}
update_command_with_values=${update_command_with_values/__VERSION_WITHOUT_V__/$version_no_v}
update_command_with_values=${update_command_with_values/__EDITION__/$EDITION}

# Print the final update command
echo "Executing: $update_command_with_values"

# Execute the final update command
eval "$update_command_with_values"