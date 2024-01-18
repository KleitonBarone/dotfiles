#!/usr/bin/env bash

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

safe_link(){
    local src="$1"
    local dest="$HOME/`basename $src`"
    [ ! -e "$dest" ] && ln -sf "$src" "$dest"
}

# Get root
SCRIPT_PATH=`realpath $0`
DOTFILES=`dirname $SCRIPT_PATH`

# link dotfiles
for f in `ls -A $DOTFILES/config`; do
    safe_link "$DOTFILES/config/$f"
done

echo ''
echo '  Finished'
