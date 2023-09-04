#!/bin/bash
# shellcheck disable=SC2068
set -euo pipefail

resources_latest_version=$(curl -v https://github.com/fkia87/resources/releases/latest 2>&1 | \
    grep -i location | rev | cut -d / -f 1 | rev | sed 's/\r//g' | cat -v)

download_resources() {
    echo -e "Downloading resources..."
    rm -rf "$resources_latest_version".tar.gz
    wget https://github.com/fkia87/resources/archive/refs/tags/"$resources_latest_version".tar.gz || \
        { echo -e "Error downloading required files from Github." >&2; exit 1; }
    tar xvf ./"$resources_latest_version".tar.gz || { echo -e "Extraction failed." >&2; exit 1; }
}

cleanup() {
    rm -rf ./resources*
}

download_resources

requirements=(
    "resources-${resources_latest_version/v/}/utils" 
    "resources-${resources_latest_version/v/}/network" 
    "resources-${resources_latest_version/v/}/bash_colors"
    )

for file in ${requirements[@]}; do
    install -m 644 "$file" "/etc/profile.d/${file##*/}.sh"
done

install -m 755 ./wgutil /usr/bin && echo "Installation done."