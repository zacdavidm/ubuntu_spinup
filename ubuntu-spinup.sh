#!/bin/bash


# Function stub
# function uspin_ {
#
# }


# Fix touchpad issue
function uspin_touchpad_fix {
  #turn off two finger click as right click (issue when navigating using middle finger and clicking with index).
  #https://wiki.ubuntu.com/Multitouch/TouchpadSupport
  touch .touchpad.sh

  echo 'synclient ClickFinger2=0' >> ~/.touchpad.sh

  chmod +x ~/.touchpad.sh

  gsettings set org.gnome.settings-daemon.peripherals.input-devices hotplug-command “~/.touchpad.sh”
  #create shell script so property stays set.
}


# Remove amazon from unity.
function uspin_amazon_rm {
  sudo apt-get remove unity-lens-shopping -y
}

# Install Atom.io
function uspin_atom {
  wget https://atom.io/download/deb -O atom-amd64.deb

  sudo dpkg -i atom-amd64.deb

  sudo apt-get install -f

  rm atom-amd64.deb
}


# Set Atom.io to default editor.
function uspin_atom_default {
  xdg-mime default atom.desktop text/plain
}


# Install Arcanist for Phabricator
function uspin_arc {
  # -Need php5, php5-curl first
  # sudo apt-get install php5 php5-curl -y

  # git clone arcanist and requirement library
  # git clone https://github.com/phacility/libphutil.git
  # git clone https://github.com/phacility/arcanist.git
  # move both to /opt
  # add arcanist/bin to path.

  sudo apt-get install arcanist -y
}


# Install Chrome.
function uspin_chrome {

  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

  sudo dpkg -i google-chrome*.deb

  sudo apt-get install -f

  rm google-chrome*.deb
}


# Install Composer.
function uspin_composer {
  EXPECTED_SIGNATURE=$(wget https://composer.github.io/installer.sig -O - -q)
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

  if [ "$EXPECTED_SIGNATURE" = "$ACTUAL_SIGNATURE" ]
  then
      php composer-setup.php --quiet
      RESULT=$?
      rm composer-setup.php
      exit $RESULT
  else
      >&2 echo 'ERROR: Invalid installer signature'
      rm composer-setup.php
      exit 1
  fi
  echo "sudo mv composer.phar /usr/local/bin/composer"
}


# Install FileZilla.
function uspin_filezilla {
  sudo apt-get install filezilla -y
}


# Install Git.
function uspin_git {
  sudo apt-get install git -y
}


# Install Java.
function uspin_java {
  sudo apt-get install openjdk-6-jre
}


# Set Launcher Empty
function uspin_launcher_empty {
  gsettings set com.canonical.Unity.Launcher favorites []
}

# Build Launcher
function uspin_launcher_build {
  # TODO: make this properly build parameter for set, and probably make so can
  # pass values to it

  #Build the Launcher Favorites array
  FAVORITES=()

  #Add Running apps to launcher
  FAVORITES+=('unity://running-apps')

  #Add Files to Launcher
  #gsettings set com.canonical.Unity.Launcher favorites "$(gsettings get com.canonical.Unity.Launcher favorites | sed "s/, *'org.gnome.Nautilus.desktop' *//g" | sed "s/'org.gnome.Nautilus.desktop' *, *//g" | sed -e "s/]$/, 'org.gnome.Nautilus.desktop']/")"
  FAVORITES+=('application://org.gnome.Nautilus.desktop')

  #Add Chrome to Launcher
  #gsettings set com.canonical.Unity.Launcher favorites "$(gsettings get com.canonical.Unity.Launcher favorites | sed "s/, *'google-chrome.desktop' *//g" | sed "s/'google-chrome.desktop' *, *//g" | sed -e "s/]$/, 'google-chrome.desktop']/")"
  FAVORITES+=('application://google-chrome.desktop')

  #Add Firefox to Launcher
  #gsettings set com.canonical.Unity.Launcher favorites "$(gsettings get com.canonical.Unity.Launcher favorites | sed "s/, *'firefox.desktop' *//g" | sed "s/'firefox.desktop' *, *//g" | sed -e "s/]$/, 'firefox.desktop']/")"
  FAVORITES+=('application://firefox.desktop')

  #Add Terminal to Launcher
  FAVORITES+=('application://gnome-terminal.desktop')

  #Add Atom to Launcher
  #gsettings set com.canonical.Unity.Launcher favorites "$(gsettings get com.canonical.Unity.Launcher favorites | sed "s/, *'atom.desktop' *//g" | sed "s/'atom.desktop' *, *//g" | sed -e "s/]$/, 'atom.desktop']/")"
  FAVORITES+=('application://atom.desktop')

  #Add FileZilla to Launcher
  #gsettings set com.canonical.Unity.Launcher favorites "$(gsettings get com.canonical.Unity.Launcher favorites | sed "s/, *'filezilla.desktop' *//g" | sed "s/'filezilla.desktop' *, *//g" | sed -e "s/]$/, 'filezilla.desktop']/")"
  FAVORITES+=('application://filezilla.desktop')

  #Add devices to favorites list
  FAVORITES+=('unity://devices')

  #THIS NEEDS TO BE IN FORMAT "['value', 'value', 'value']"
  #gsettings set com.canonical.Unity.Launcher favorites $FAVORITES
}

# Launcher set
function uspin_launcher_set {
  # TODO: Make this so it takes var from build and appends [] and sets the val.
  gsettings set com.canonical.Unity.Launcher favorites "['unity://running-apps', 'application://filezilla.desktop', 'application://firefox.desktop', 'application://google-chrome.desktop', 'application://org.gnome.Nautilus.desktop', 'application://gnome-terminal.desktop', 'application://atom.desktop', 'unity://devices']"
}


# Install Subversion.
function uspin_subversion {
  sudo apt-get install subversion -y
}


# Install Vagrant
function uspin_vagrant {
  sudo apt-get install vagrant -y
}


# Install VirtualBox.
function uspin_virtualbox {
  #may not need to be done. may be done auto-matically by vagrant
}
