#!/bin/bash
for dir in .config/*; do
    if [ -d "$dir" ]; then
        if [ -d "$HOME/.config/$(basename $dir)" ]; then
            if [ -L "$HOME/.config/$(basename $dir)" ]; then
                rm ~/.config/$(basename $dir)
            else
                mv ~/.config/$(basename $dir) ~/.config/old_$(basename $dir)
            fi
        fi
        ln -s $(realpath $dir) ~/.config/$(basename $dir)
    fi
done

if [ ! -L "$HOME/.bashrc" ]; then
    rm -f ~/.bashrc
    ln -s $(realpath .bashrc) ~/.bashrc
fi
