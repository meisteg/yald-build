#!/bin/bash

# Abort script if any command returns error
set -e

_usage() {
    echo "Usage: $0 <command> [OPTIONS]"
    echo "  Commands:"
    echo "      init - Initialize repositories"
    exit 1
}

_clone() {
    for (( i=0; i<${#repo_urls[@]}; i++ ));
    do
    
        if [ -d ${repo_dirs[$i]} ]; then
            if [ "$force" = true ] ; then
                echo "Removing ${repo_dirs[$i]}"
                rm -fr ${repo_dirs[$i]}
            else
                echo "Warning: Directory ${repo_dirs[$i]} exists. Skipping..."
                continue
            fi
        fi

        mkdir -p ${repo_dirs[$i]}
        pushd ${repo_dirs[$i]} > /dev/null
        git init
        git remote add origin ${repo_urls[$i]}
        git fetch origin
        git checkout -q ${repo_heads[$i]}
        git checkout -b repo-mgr
        popd > /dev/null

        echo ""
    done
}

_parse_conf() {
    if [ ! -f $conf_file ]; then
        echo "$conf_file not found!"
        exit 1
    fi

    echo -e "Parsing $conf_file\n"
    repo_urls=( $(grep ^repository $conf_file | cut -d ',' -f2) )
    repo_dirs=( $(grep ^repository $conf_file | cut -d ',' -f3) )
    repo_heads=( $(grep ^repository $conf_file | cut -d ',' -f4) )
}

init() {
    conf_file="default.conf"
    force=false

    while [[ $# -gt 0 ]]; do
        case $1 in
            -f|--file)
                if [ -z "$2" ]
                then
                    echo "No file specified"
                    _usage
                fi

                conf_file="$2"
                shift # past argument
                shift # past value
                ;;
            -z)
                force=true
                shift
                ;;
            *)
                echo "Unknown option: $1"
                exit 1
                ;;
        esac
    done

    _parse_conf
    _clone
}

if [[ $# -eq 0 ]] ; then
    _usage
fi

case $1 in
    init)
        shift
        init "$@"
        ;;
    *)
        echo "Unknown command $1"
        _usage
        ;;
esac
