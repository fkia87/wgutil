#!/usr/bin/env bash
# shellcheck disable=SC2207,SC2068

_wgutil_user_generator() {
    find "$clients_folder" -mindepth 1 -type d | rev | cut -d '/' -f 1 | rev
}

_wgutil_iface_generator() {
    basename -s '.conf' "$(ls "$iface_folder"/*.conf )"
}

_wgutil_completions() {
    # local cur prev opts
    local clients_folder='/etc/wireguard/*/clients/'
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
            mapfile -t COMPREPLY < <(compgen -W "$(_wgutil_user_generator)" -- "$cur")
            ;;
        lsuser|delif|backup)
            mapfile -t COMPREPLY < <(compgen -W "$(_wgutil_iface_generator)" -- "$cur")
            ;;
        restore)
            mapfile -t COMPREPLY < <(compgen -o nospace -f -- "$cur")
            ;;
    esac

    case "$p_prev" in 
        deluser|adduser|getuser)
            mapfile -t COMPREPLY < <(compgen -W "$(_wgutil_iface_generator)" -- "$cur")
            ;;
    esac

    return 0
}

#complete -o nospace -F _wgutil_completions wgutil
complete -F _wgutil_completions wgutil