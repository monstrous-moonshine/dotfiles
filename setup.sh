#!/bin/bash

realpath() {
    echo "$(cd "$(dirname -- "$1")" >/dev/null; pwd -P)/$(basename -- "$1")"
}

script_dir="$(realpath "$0")"
script_dir="$(dirname "$script_dir")"
script_dir="${script_dir/"$HOME/"/}"

cd $HOME

install() {
    for f in vimrc tmux.conf gitconfig; do
        ln -sv "$script_dir/$f" ".$f"
    done
    for f in qpdfview qtile picom.conf; do
        ln -sv "../$script_dir/config/$f" .config
    done
}

install
