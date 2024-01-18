#!/usr/bin/env bash

# Get root
SCRIPT_PATH=`realpath $0`
DOTFILES=`dirname $SCRIPT_PATH`

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

force_link(){
    local src="$1"
    local dest="$HOME/`basename $src`"
    ln -sf "$src" "$dest"
}

link_files(){
for f in `ls -A $DOTFILES/config`; do
    force_link "$DOTFILES/config/$f"
done
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	linkFiles;
    echo "Finished Successfully";
    exit 0
fi;

read -p "This may overwrite existing files in your home directory. Are you sure? (y/N) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	linkFiles;
    echo "Finished Successfully";
    exit 0
fi;

echo "Ended without linking";
exit 0
