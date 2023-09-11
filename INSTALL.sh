#!/bin/bash
# shellcheck disable=SC2068
# shellcheck source=/dev/null

# IMPORT REQUIREMENTS ##################################################################################
install_resources() {
    [[ $UID == "0" ]] || { echo "You are not root." >&2; exit 1; }
    local resources_latest_version
    resources_latest_version=$(
        curl -v https://github.com/fkia87/resources/releases/latest 2>&1 | \
        grep -i location | rev | cut -d / -f 1 | rev | sed 's/\r//g'
    )
    echo -e "Downloading resources..."
    rm -rf "$resources_latest_version".tar.gz
    wget https://github.com/fkia87/resources/archive/refs/tags/"$resources_latest_version".tar.gz || \
        { echo -e "Error downloading required files from Github." >&2; exit 1; }
    tar xvf ./"$resources_latest_version".tar.gz || { echo -e "Extraction failed." >&2; exit 1; }
    cd ./resources-"${resources_latest_version/v/}" || exit 2
    ./INSTALL.sh -q
    cd .. || exit 2
    rm -rf ./resources*
    . /etc/profile
}

install_resources
#################################################################################

install -v -m 755 ./wgutil /usr/bin/wgutil