
# Constants
EXPECTED_DISTRIB_ID="Ubuntu"
EXPECTED_DISTRIB_RELEASE="22.04"

# Checking the current OS
echo "Checking the current OS..."
. /etc/lsb-release
if [ $DISTRIB_ID != $EXPECTED_DISTRIB_ID ];
then
  echo "Distribution is not ${EXPECTED_DISTRIB_ID}: ${DISTRIB_ID}"
  exit
fi
if [ $DISTRIB_RELEASE != $EXPECTED_DISTRIB_RELEASE ];
then
  echo "Version is not ${EXPECTED_DISTRIB_RELEASE}: ${DISTRIB_RELEASE}"
  exit
fi

# Variables
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Ready
read -p "Ready to install. Press [ENTER] to start..."

# Replace sources.list
echo "Replacing sources.list..."
sudo cp "${SCRIPT_DIR}/files/sources.list" /etc/apt/sources.list

# Update and upgrade
echo "Running update and upgrade..."
sudo apt update
sudo apt -u dist-upgrade --yes

# Install other packages
echo "Installing other packages..."
sudo apt install --yes \
  ffmpeg \
  git \
  gparted \
  httpie \
  jq \
  libxcb-xinerama0 \
  libxcb-xtest0 \
  libegl1-mesa \
  libgl1-mesa-glx \
  mc \
  meld \
  neovim \
  pavucontrol \
  tldr \
  v4l2loopback-dkms

# Uninstall packages
echo "Uninstalling packages..."
sudo apt remove --yes \
  update-manager

# Remove unnecessary packages
echo "Removing unnecessary packages..."
sudo apt autoremove

# Install google chrome
echo "Installing google-chrome..."
wget -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/chrome.deb
rm -rf /tmp/chrome.deb

# Install zoom
wget -O /tmp/zoom.deb https://cdn.zoom.us/prod/5.11.3.3882/zoom_amd64.deb
sudo dpkg -i /tmp/zoom.deb
rm -rf /tmp/zoom.deb

# Install instagram-live-streamer
echo "Installing instagram-live-streamer..."
wget -O /tmp/instagram-live-streamer.deb https://github.com/haxzie/instagram-live-streamer/releases/download/0.2.1/instagram-live-streamer_0.2.1_amd64.deb
sudo dpkg -i /tmp/instagram-live-streamer.deb
rm -rf /tmp/instagram-live-streamer.deb

# Install visual studio code
echo "Installing visual studio code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/packages.microsoft.gpg
sudo install -o root -g root -m 644 /tmp/packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f /tmp/packages.microsoft.gpg
sudo apt update
sudo apt install --yes code

# Install OBS
echo "Installing OBS..."
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt install --yes obs-studio

# Install bash git prompt
echo "Installing bash git prompt..."
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt

# Install node
echo "Installing nodejs..."
mkdir -p ~/src/node
pushd ~/src/node
wget https://nodejs.org/dist/v16.17.0/node-v16.17.0-linux-x64.tar.xz
tar xvf node-v16.17.0-linux-x64.tar.xz
popd

# Install yt-dlp
echo "Installing yt-dlp..."
mkdir -p ~/bin
wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O ~/bin/yt-dlp
chmod a+x ~/bin/yt-dlp

# Install expressvpn
echo "Installing expressvpn..."
wget https://www.expressvpn.works/clients/linux/expressvpn_3.30.0.2-1_amd64.deb -O /tmp/expressvpn.deb
sudo dpkg -i /tmp/expressvpn.deb
rm -rf /tmp/expressvpn.deb

# Copy .bashrc
echo "Copying .bashrc..."
cp "${SCRIPT_DIR}/files/bashrc" ~/.bashrc

# Disable sudo passwd
echo "Disabling sudo passwd..."
sudo cp "${SCRIPT_DIR}/files/nopasswd" /etc/sudoers.d/nopasswd

# Disable packagekit
echo "Disabling packagekit..."
sudo systemctl stop packagekit
sudo systemctl disable packagekit

# Show seconds in clock
echo "Showing seconds in clock..."
gsettings set org.gnome.desktop.interface clock-show-seconds true

# Generate SSH key
echo "Generating SSH key..."
mkdir -p ~/.ssh
ssh-keygen -f ~/.ssh/id_rsa -N ""

# Configure git
echo "Configuring git..."
read -p "Enter your name: " FULLNAME
read -p "Enter your email: " EMAIL
git config --global user.name "${FULLNAME}"
git config --global user.email "${EMAIL}"
