
# Replace sources.list
echo "Replacing sources.list..."
sudo cp files/sources.list /etc/apt/sources.list

# Update and upgrade
echo "Running update and upgrade..."
sudo apt update
sudo apt -u dist-upgrade

# Install other packages
echo "Installing other packages..."
sudo apt install \
  apt-transport-https \
  cmake \
  ffmpeg \
  git \
  jackd \
  libegl1-mesa \
  libgl1-mesa-glx \
  libxcb-xtest0 \
  mc \
  neovim \
  pavucontrol \
  pulseaudio-module-jack \
  qjackctl \
  qtbase5-dev \
  v4l2loopback-dkms

# Uninstall packages
echo "Uninstalling packages..."
sudo apt uninstall \
  update-manager

# Install google chrome
echo "Installing google-chrome..."
wget -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/chrome.deb
rm -rf /tmp/chrome.deb

# Install zoom
wget -O /tmp/zoom.deb https://cdn.zoom.us/prod/5.6.20278.0524/zoom_amd64.deb
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
sudo apt install code

# Install cadence
echo "Installing cadence..."
sudo apt install apt-transport-https gpgv
wget -O /tmp/kxstudio.deb https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_10.0.3_all.deb
sudo dpkg -i /tmp/kxstudio.deb
sudo rm /tmp/kxstudio.deb
sudo apt update
sudo apt install cadence

# Install OBS
echo "Installing OBS..."
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt install obs-studio

# Install OBS plugins
echo "Installing OBS plugins..."
sudo apt install libobs-dev
mkdir -p ~/src
pushd ~/src
git clone --recursive https://github.com/obsproject/obs-studio.git
git clone https://github.com/CatxFish/obs-v4l2sink.git
mkdir -p ~/src/obs-v4l2sink/build
pushd ~/src/obs-v4l2sink/build
cmake -DLIBOBS_INCLUDE_DIR="../../obs-studio/libobs" -DCMAKE_INSTALL_PREFIX=/usr ..
make -j16
sudo make install
popd
popd

# Install bash git prompt
echo "Installing bash git prompt..."
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt

# Install node
echo "Installing nodejs..."
mkdir -p ~/src/node
pushd ~/src/node
wget https://nodejs.org/dist/v14.16.1/node-v14.16.1-linux-x64.tar.xz
tar xvf node-v14.16.1-linux-x64.tar.xz
popd

# Install youtube-dl
echo "Installing youtube-dl..."
mkdir -p ~/bin
wget https://yt-dl.org/downloads/latest/youtube-dl -O ~/bin/youtube-dl
chmod a+x ~/bin/youtube-dl

# Copy .bashrc
echo "Copying .bashrc..."
cp ./files/bashrc ~/.bashrc

# Disable sudo passwd
echo "Disabling sudo passwd..."
sudo cp files/nopasswd /etc/sudoers.d/nopasswd

# Show seconds in clock
echo "Showing seconds in clock..."
gsettings set org.gnome.desktop.interface clock-show-seconds true

# Generate SSH key
echo "Generating SSH key..."
mkdir -p ~/.ssh
ssh-keygen -f ~/.ssh/id_rsa -N ""

# Configure git
echo "Configuring git..."
read -p "Enter your name:" FULLNAME
read -p "Enter your email:" EMAIL
git config --global user.name "${FULLNAME}"
git config --global user.email "${EMAIL}"

