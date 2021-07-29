#!/bin/sh
PVBRANCH="${PVBRANCH:-main}"

set -o nounset # error when referencing undefined variable
set -o errexit # exit when command fails

# Directories
pennyvim_location="$HOME/.local/share/pennyvim"
config_location="$HOME/.config/pvim"

# Subdirectories
git_location="$pennyvim_location/pvim"
packer_location="$pennyvim_location/site/pack/packer/start/packer.nvim"

# Files
init_lua_location="$git_location/init.lua"
config_lua_location="$git_location/utils/config.example.lua"
bin_location="$git_location/bin/pvim"

install_packer() {
  echo ""
  echo "   +----------------------------+"
  echo "   |   Installing packer.nvim   |"
  echo "   +----------------------------+"
  echo ""
  git clone https://github.com/wbthomason/packer.nvim "$packer_location"
}

install_pynvim() {
	printf "Pynvim is not installed. Would you like to install pynvim (y/N)? "
	read -r answer
	if [ "$answer" != "${answer#[Yy]}" ]; then
    echo ""
    echo "   +-----------------------+"
    echo "   |   Installing pynvim   |"
    echo "   +-----------------------+"
    echo ""
    pip3 install --user pynvim
  else
    echo ""
    echo "   +-----------------------------------------------+"
    echo "   |         User aborted install process.         |"
    echo "   |   Please install pynvim before installing..   |"
    echo "   +-----------------------------------------------+"
    exit
  fi
}

update_pynvim() {
	printf "Would you like to update pynvim (y/N)? "
	read -r answer
	if [ "$answer" != "${answer#[Yy]}" ]; then
    echo ""
    echo "   +---------------------+"
    echo "   |   Updating pynvim   |"
    echo "   +---------------------+"
    echo ""
    pip3 install -U --user pynvim
  fi
}

install_config() {
  if [[ -v testing ]]; then
    echo ""
    echo "   +-------------------------------------+"
    echo "   |   Copying config from current dir   |"
    echo "   +-------------------------------------+"
    cp -r "$(pwd)" $git_location
  else
    echo ""
    echo "   +-----------------------------+"
    echo "   |   Cloning PennyVim config   |"
    echo "   +-----------------------------+"
    echo ""
    git clone --branch "$PVBRANCH" https://github.com/Peterkmoss/pennyvim.git "$git_location"
  fi


  # Install bin / alias
  echo ""
  echo 'Copying executable to /usr/local/bin'
  (command -v doas >/dev/null && doas cp "$bin_location" "/usr/local/bin") || (command -v sudo >/dev/null && sudo cp "$bin_location" "/usr/local/bin") 

  echo ""
  echo "Copying example config"
  echo ""
  echo "Creating directory ~/.config/pvim (unless already existing)"
  mkdir -p "$config_location"
  echo ""
  cp -iv "$config_lua_location" "$config_location/config.lua"

  echo ""
  echo "Installing built in plugins"

  nvim -u $init_lua_location \
    --cmd "set runtimepath+=$git_location" \
    --headless \
		+'autocmd User PackerComplete sleep 100m | qall' \
    +PackerInstall

  nvim -u $init_lua_location \
    --cmd "set runtimepath+=$git_location" \
    --headless \
		+'autocmd User PackerComplete sleep 100m | qall' \
    +PackerSync

  echo ""
  echo "   +----------------------+"
  echo "   |   Install complete   |"
  echo "   +----------------------+"
}

case "$@" in
  *--testing*)
    echo ""
    echo "   +--------------------------+"
    echo "   |   Running test install   |"
    echo "   +--------------------------+"
    testing=1
esac

echo ""
echo "   +-------------------------+"
echo "   |   Installing PennyVim   |"
echo "   +-------------------------+"

case "$@" in
  *--reinstall*)
    echo ""
    echo "   +-----------------------------------------------+"
    echo "   |                 !!REINSTALL!!                 |"
    echo "   |   Removing current install due to reinstall   |"
    echo "   +-----------------------------------------------+"

    echo ""
    echo "3... (use CTRL-c to cancel)"
    sleep 1
    echo "2... (use CTRL-c to cancel)"
    sleep 1
    echo "1... (use CTRL-c to cancel)"
    sleep 1

    echo ""
    echo "Removing $pennyvim_location"
    rm -rf "$pennyvim_location"

    echo ""
    echo "Removing compiled plugin file from $config_location/plugin"
    rm -rf "$config_location/plugin"

    echo ""
    echo "Removing cached data from $HOME/.cache/nvim"
    rm -rf "$HOME/.cache/nvim"
    ;;
esac

if [ -d "$git_location" ]; then
    echo ""
    echo "   +---------------------------------------------+"
    echo "   |          PennyVim aready installed          |"
    echo "   |   Use the '--reinstall' flag to reinstall   |"
    echo "   +---------------------------------------------+"
    exit
fi

echo ""
echo "Creating directory ~/.local/share/pennyvim"
mkdir -p $pennyvim_location

if [ -e "$packer_location" ]; then
  echo ""
	echo 'packer is already installed - skipping...'
else
	install_packer
fi

# Check for pip3
(command -v pip3 >/dev/null || (echo "\npip3 not installed. Please install before trying again" && exit))

# Check for pynvim
(pip3 list | grep pynvim >/dev/null && update_pynvim) || install_pynvim

install_config

echo ""
echo "   +--------------------------------------------------------------------------------------------------------------+"
echo "   |   Example configuration added to ~/.config/pvim/config.lua. Edit this file to make your own configuration.   |"
echo "   +--------------------------------------------------------------------------------------------------------------+"
echo ""
echo "   +---------------------------------------------------------------------------+"
echo "   |   Install language servers (LSP) using the command ':LspInstall <lang>'   |"
echo "   +---------------------------------------------------------------------------+"
