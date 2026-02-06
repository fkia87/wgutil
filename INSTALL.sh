#!/bin/bash
# shellcheck disable=SC2068
# shellcheck source=/dev/null
# cSpell:disable

checkuser() {
    [[ $UID == "0" ]] || { echo "You are not root." >&2; exit 1; }
}
checkuser

# comp_location='/etc/bash_completion.d'
comp_location=/usr/share/bash-completion/completions
comp_script=./wgutil-completion.bash

install -v -m 755 ./wgutil /usr/bin/wgutil && \
    echo -e "\nInstallation Successfull!\n"
mkdir -p "$comp_location"
install -v -m 644 $comp_script "$comp_location"/wgutil && \
    {
        echo -e "\nPlease run this command to activate \"wgutil\" auto completion:\n";
        echo -e "source ${comp_location}/wgutil\n";
        echo -e "Or simply restart your shell.";
    }