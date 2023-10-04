#!/usr/bin/env bash
# shellcheck disable=SC2207,SC2068

_wgutil_completions() {
    # local cur prev opts
    local clients_folder='/etc/wireguard/wg0/clients/'
    local iface_folder='/etc/wireguard/'
    COMPREPLY=()
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"
    local p_prev="${COMP_WORDS[COMP_CWORD-2]}"
    local opts="adduser deluser addif delif lsuser getuser backup restore install lsif"

    case "$prev" in
        wgutil)
            mapfile -t COMPREPLY < <(compgen -W "$opts" -- "$cur")
            ;;
        deluser|getuser)
            mapfile -t COMPREPLY < <(compgen -W "$(ls ${clients_folder})" -- "$cur")
            ;;
        lsuser|delif|backup)
            mapfile -t COMPREPLY < <(compgen -W "$(basename -s '.conf' \
                "$(ls ${iface_folder}/*.conf )")" -- "$cur")
            ;;
        restore)
            mapfile -t COMPREPLY < <(compgen -o nospace -f -- "$cur")
            ;;
    esac

    case "$p_prev" in 
        deluser|adduser|getuser)
            mapfile -t COMPREPLY < <(compgen -W "$(basename -s '.conf' \
                "$(ls ${iface_folder}/*.conf )")" -- "$cur")
            ;;
    esac

    return 0
}

#complete -o nospace -F _wgutil_completions wgutil
complete -F _wgutil_completions wgutil