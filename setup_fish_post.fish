#!/usr/bin/env fish
# This sets up the fish shell and stuffs

# install the batman shell theme
omf install batman
omf install cd
omf install colorman

# fisher package manager is bootstrapped in config.fish already
fisher add franciscolourenco/done
fisher add jethrokuan/z
fisher add jorgebucaran/fish-spark
fisher add laughedelic/pisces
fisher add jichu4n/fish-command-timer
echo "source ~/.config/fish/conf.d/fish_command_timer.fish" >> ~/.config/fish/extras.fish
