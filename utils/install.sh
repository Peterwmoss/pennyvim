#!/bin/bash
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
  echo "   +------------INFO------------+"
  echo "   |   Installing packer.nvim   |"
  echo "   +------------INFO------------+"
  echo ""
  git clone https://github.com/wbthomason/packer.nvim "$packer_location"
}

install_pynvim() {
  if [[ -v yes ]]; then
    pip3 install --user pynvim
    return
  fi

  printf "Pynvim is not installed. Would you like to install pynvim (y/N)? "
  read -r answer
  if [ "$answer" != "${answer#[Yy]}" ]; then
    echo ""
    echo "   +---------INFO----------+"
    echo "   |   Installing pynvim   |"
    echo "   +---------INFO----------+"
    echo ""
    pip3 install --user pynvim
  else
    echo ""
    echo "   +---------------------ERROR---------------------+"
    echo "   |          User aborted install process         |"
    echo "   |    Please install pynvim before installing    |"
    echo "   +---------------------ERROR---------------------+"
    exit
  fi
}

update_pynvim() {
  if [[ -v yes ]]; then
    pip3 install -U --user pynvim
    return
  fi

  printf "Would you like to update pynvim (y/N)? "
  read -r answer
  if [ "$answer" != "${answer#[Yy]}" ]; then
    echo ""
    echo "   +--------INFO---------+"
    echo "   |   Updating pynvim   |"
    echo "   +--------INFO---------+"
    echo ""
    pip3 install -U --user pynvim
  fi
}

copy_executable() {
    echo ""
    echo "Copying executable to $1"
    (command -v doas >/dev/null && doas cp "$bin_location" "$1") || (command -v sudo >/dev/null && sudo cp "$bin_location" "$1") 
}

install_config() {
  if [[ -v testing ]]; then
    if [ ! -d $git_location ]; then
      echo ""
      echo "   +----------------------------------------+"
      echo "   |   Symlinking config from current dir   |"
      echo "   +----------------------------------------+"
      ln -sv "$(pwd)" $git_location
    else
      echo "Fatal: $git_location already exists..."
      exit 1
    fi
  else
    echo ""
    echo "   +-----------------------------+"
    echo "   |   Cloning PennyVim config   |"
    echo "   +-----------------------------+"
    echo ""
    git clone --branch "$PVBRANCH" https://github.com/Peterkmoss/pennyvim.git "$git_location"
  fi

  echo ""
  echo "Copying example config"
  echo ""
  echo "Creating directory ~/.config/pvim (unless already existing)"
  mkdir -p "$config_location"
  echo ""
  if [[ -v yes ]]; then
    cp -v "$config_lua_location" "$config_location/config.lua"
  else
    cp -iv "$config_lua_location" "$config_location/config.lua"
  fi

  echo ""
  echo "Installing built in plugins"

  echo ""
  echo "Running ':PackerSync'"
  (nvim -u $init_lua_location \
    --cmd "set runtimepath+=$git_location" \
    --headless \
		+'autocmd User PackerComplete sleep 50m | qall' \
    +PackerSync)

  if [ -d "/usr/local/bin" ]; then
    copy_executable "/usr/local/bin"
  elif [ -d "/usr/bin"  ]; then
    copy_executable "/usr/bin"
  else
    echo ""
    echo "   +-------------------------------------IMPORTANT-------------------------------------+"
    echo "   |                                                                                   |"
    echo "   |       Couldn't copy to /usr/local/bin or /usr/bin, directory does not exist       |"
    echo "   |   Please ensure that you put the executable in a location which is in your PATH   |"
    echo "   |                                                                                   |"
    echo "   +-------------------------------------IMPORTANT-------------------------------------+"
    echo ""
    echo "   Executable is found in $bin_location"
  fi

  echo ""
  echo "   +-----------------------------------------------------------INSTALL COMPLETE------------------------------------------------------------+"
  echo "   |                                                                                                                                       |"
  echo "   |                Example configuration added to ~/.config/pvim/config.lua. Edit this file to make your own configuration                |"
  echo "   |                                                                                                                                       |"
  echo "   |                                 Install language servers (LSP) using the command ':LspInstall <lang>'                                 |"
  echo "   |                                                                                                                                       |"
  echo "   |   At first start, TreeSitter will install languages, after which a restart of PennyVim is required for TreeSitter to work properly.   |"
  echo "   |                                                                                                                                       |"
  echo "   +-----------------------------------------------------------INSTALL COMPLETE------------------------------------------------------------+"
  echo ""
}

case "$@" in
  *-y*)
    yes=1
    ;;

  *--yes*)
    yes=1
    ;;
esac

case "$@" in
  *--testing*)
    echo ""
    echo "   +-----------INFO-----------+"
    echo "   |   Running test install   |"
    echo "   +-----------INFO-----------+"
    testing=1
    ;;
esac

echo ""
echo "   +------------INFO------------+"
echo "   |   Installing PennyVim...   |"
echo "   +------------INFO------------+"

case "$@" in
  *--reinstall*)
    echo ""
    echo "   +-------------------IMPORTANT-------------------+"
    echo "   |                                               |"
    echo "   |                !! REINSTALL !!                |"
    echo "   |   Removing current install due to reinstall   |"
    echo "   |                                               |"
    echo "   +-------------------IMPORTANT-------------------+"

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
    echo "   +--------------------ERROR--------------------+"
    echo "   |          PennyVim aready installed          |"
    echo "   |   Use the '--reinstall' flag to reinstall   |"
    echo "   +--------------------ERROR--------------------+"
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
