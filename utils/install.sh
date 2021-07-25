# Directories
pennyvim_location="$HOME/.local/share/pennyvim"
config_location="$HOME/.config/pvim"

# Subdirectories
git_location="$pennyvim_location/pvim"
packer_location="$pennyvim_location/site/pack/packer/start/packer.nvim"

# Files
init_lua_location="$pennyvim_location/pvim/init.lua"
config_lua_location="$pennyvim_location/pvim/utils/config.example.lua"
bin_location="$pennyvim_location/pvim/bin/pvim"

install_packer() {
  echo ""
  echo "   +----------------------------+"
  echo "   |   Installing packer.nvim   |"
  echo "   +----------------------------+"
  echo ""
  git clone https://github.com/wbthomason/packer.nvim "$packer_location"
}

install_config() {

  echo ""
  mkdir -vp $pennyvim_location

  echo ""
  echo "   +-----------------------------+"
  echo "   |   Cloning PennyVim config   |"
  echo "   +-----------------------------+"
  echo ""
  git clone https://github.com/Peterkmoss/pennyvim.git "$git_location"


  # Install bin / alias
  echo ""
  echo 'Copying executable to /usr/local/bin'
  (command -v doas >/dev/null && doas cp "$bin_location" "/usr/local/bin") || (command -v sudo >/dev/null && sudo cp "$bin_location" "/usr/local/bin") 

  echo ""
  mkdir -vp "$config_location"
  echo ""
  cp -v "$config_lua_location" "$config_location/config.lua"

  echo ""
  echo "Installing built in plugins"

  nvim -u "$init_lua_location" --cmd "set runtimepath+=$git_location" --headless \
    +'au User PackerComplete sleep 100m | qall' \
    +PackerInstall

  nvim -u "$init_lua_location" --cmd "set runtimepath+=$git_location" --headless \
    +'au User PackerComplete sleep 100m | qall' \
    +PackerSync

  echo ""
  echo "   +----------------------+"
  echo "   |   Install complete   |"
  echo "   +----------------------+"
}

echo ""
echo "   +-------------------------+"
echo "   |   Installing PennyVim   |"
echo "   +-------------------------+"

case "$@" in
  *--reinstall*)
    echo ""
    echo "   +--------------------------------------------------+"
    echo "   |                  !!REINSTALL!!                   |"
    echo "   |   Removing all current config due to reinstall   |"
    echo "   +--------------------------------------------------+"

    echo ""
    echo "5..."
    sleep 1
    echo "4..."
    sleep 1
    echo "3..."
    sleep 1
    echo "2..."
    sleep 1
    echo "1..."
    sleep 1

    echo ""
    echo "Removing $pennyvim_location"
    rm -rf "$pennyvim_location"

    echo ""
    echo "Removing $config_location"
    rm -rf "$config_location"
    ;;
esac

[ -d "$pennyvim_location" ] && echo 'PennyVim already installed' && exit

if [ -e "$packer_location" ]; then
  echo ""
	echo 'packer is already installed... skipping'
else
	install_packer
fi

if [ -e "$init_lua_location" ]; then
  echo ""
  echo 'PennyVim already installed. To reinstall provide the --reinstall option'
else
  install_config
fi

echo ""
echo "   +-------------------------------------------------------------------------------------------------------------+"
echo "   |   Example configuration added to ~/.config/pvim/config.lua. Edit this file to make your own configuration   |"
echo "   +-------------------------------------------------------------------------------------------------------------+"
echo ""
echo "   +---------------------------------------------------------------------------+"
echo "   |   Install language servers (LSP) using the command ':LspInstall <lang>'   |"
echo "   +---------------------------------------------------------------------------+"
echo ""
