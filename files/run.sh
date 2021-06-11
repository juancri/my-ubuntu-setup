
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
  git \
  libegl1-mesa \
  libgl1-mesa-glx \
  libxcb-xtest0 \
  neovim \
  obs-plugins \
  obs-studio

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

# Install bash git prompt
echo "Installing bash git prompt..."
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt


