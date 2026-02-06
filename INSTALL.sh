#!/bin/bash
# shellcheck disable=SC2068
# shellcheck source=/dev/null
# cSpell:disable

# comp_location='/etc/bash_completion.d'
comp_location=/usr/share/bash-completion/completions


install -v -m 755 ./wgutil /usr/bin/wgutil && \
    echo -e "\nInstallation Successfull!\n"
mkdir -p "$comp_location"
install -v -m 644 ./wgutil-completion.bash "$comp_location"/wgutil && \
    {
        echo -e "\nPlease run this command to activate \"wgutil\" auto completion:\n";
        echo -e "source ${comp_location}/wgutil\n";
    }