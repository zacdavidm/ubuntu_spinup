#!/bin/bash
# where am i? move to where I am. This ensures source is properly sourced
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

# An example of an install.

# include the spinup functions
. $DIR/ubuntu-spinup.sh

cd ~/Downloads

# list the spinups you want to perform

uspin_amazon_rm

uspin_git
uspin_arc
uspin_composer

uspin_vagrant
uspin_atom
uspin_atom_default
uspin_chrome
uspin_meld

uspin_launcher_empty
uspin_launcher_set

git config --global user.email "you@example.com"
git config --global user.name "Your Name"
