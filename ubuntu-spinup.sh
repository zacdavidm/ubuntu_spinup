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

  sudo apt-get install -f -y

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
      rm composer-setup.php
      echo "Composer Successfully Installed"
  else
      >&2 echo 'ERROR: Invalid installer signature'
      rm composer-setup.php
      echo "Composer Installation Failed"
  fi
  sudo mv composer.phar /usr/local/bin/composer
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

function uspin_rm_firefox {
  sudo apt-get remove firefox
}

function uspin_firefox {
  wget -O firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US"
  tar jxf firefox*
  sudo mv firefox /opt/
  sudo ln -s /opt/firefox/firefox /usr/bin/firefox
}

function uspin_node {
  sudo apt-get install nodejs -y
  sudo apt-get install npm -y
  mkdir ~/.npm-global
  npm config set prefix '~/.npm-global'
  echo "if [ -d \"$HOME/.npm-global/bin\" ] ; then" >> ~/.profile
  echo "  PATH=\"$HOME/.npm-global/bin:$PATH\"" >> ~/.profile
  echo "fi" >> ~/.profile
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

# Install meld
function uspin_meld {
  sudo apt-get install meld -y
}

# Install Rbenv
function uspin_rbenv {
  sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev -y
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  source ~/.bashrc
  type rbenv
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  rbenv install -l
  rbenv install 2.3.1
  rbenv global 2.3.1
  ruby -v
}

# Install Ruby
function uspin_ruby {
  # from https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-16-04
  uspin_rbenv
}

# Install Ruby
function uspin_sass {
  gem install sass
  gem uninstall -a sass-globbing
  gem install sass-globbing -v 1.1.0
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
  sudo apt-get install virtualbox virtualbox-ext-pack -y
}

# Install VPNC.
function uspin_vpn {
  sudo apt-get install network-manager-vpnc network-manager-vpnc-gnome -y
  # Probably have to log out and log back in for vpnc options to be available
}

function uspin_slack {
  wget https://downloads.slack-edge.com/linux_releases/slack-desktop-2.8.2-amd64.deb

  sudo dpkg -i slack-desktop*.deb

  sudo apt-get install -f -y

  rm slack-desktop*.deb
}

# Uninstall Thunderbird.
function uspin_rm_thunderbird {
  sudo apt-get remove thunderbird -y
  # Probably have to log out and log back in for vpnc options to be available
}

function uspin_python_dev {
  sudo apt install python3-pip python3-devel -y
}

function uspin_curl_ca {
  sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y
}

function uspin_docker {
  uspin_python_dev
  uspin_curl_ca
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   zesty \
   stable"
   sudo apt-get update
   sudo install docker-ce -y
   pip3 install requests --upgrade --user
   pip3 install docker --upgrade --user
   # pip3 install docker-compose
   sudo curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose

   sudo groupadd docker
   sudo usermod -aG docker $USER
   sudo systemctl enable docker
}

function uspin_pritunl {
  sudo tee -a /etc/apt/sources.list.d/pritunl.list << EOF
  deb http://repo.pritunl.com/stable/apt zesty main
EOF

  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
  sudo apt-get update
  sudo apt-get install pritunl-client-gtk
}
