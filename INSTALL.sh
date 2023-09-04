#!/bin/bash
# shellcheck disable=SC2068
set -euo pipefail

[[ $UID == "0" ]] || { echo "You are not root." >&2; exit 1; }

install_resources() {
    echo -e "Downloading resources..."
    rm -rf "$resources_latest_version".tar.gz
    wget https://github.com/fkia87/resources/archive/refs/tags/"$resources_latest_version".tar.gz || \
        { echo -e "Error downloading required files from Github." >&2; exit 1; }
    tar xvf ./"$resources_latest_version".tar.gz || { echo -e "Extraction failed." >&2; exit 1; }
    cd ./resources-"${resources_latest_version/v/}" || exit 2
    ./INSTALL.sh
    cd .. || exit 2
    rm -rf ./resources*
}

#################################################################################

resources_latest_version=$(
    curl -v https://github.com/fkia87/resources/releases/latest 2>&1 | \
    grep -i location | rev | cut -d / -f 1 | rev | sed 's/\r//g'
    )

install_resources

install -v -m 755 ./wgutil /usr/bin/wgutil && exit 0

exit 1