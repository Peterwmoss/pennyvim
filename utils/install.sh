# Directories
pennyvim_location="$HOME/.local/share/pennyvim"
config_location="$HOME/.config/pvim"

# Subdirectories
git_location="$pennyvim_location/pvim"
packer_location="$pennyvim_location/site/pack/packer/start/packer.nvim"

# Files
init_lua_location="$pennyvim_location/pvim/init.lua"
config_lua_location="$pennyvim_location/pvim/utils/config-example.lua"
bin_location="$pennyvim_location/pvim/bin/pvim"

install_packer() {
  git clone https://github.com/wbthomason/packer.nvim "$packer_location"
}

install_config() {
  echo 'Cloning pvim config...'
  mkdir -p $pennyvim_location

  git clone https://github.com/Peterkmoss/pennyvim.git "$git_location"

  # Install bin / alias
  (command -v doas >/dev/null && doas cp "$bin_location" "/usr/local/bin") || (command -v sudo >/dev/null && sudo cp "$bin_location" "/usr/local/bin") 

  mkdir -p "$config_location"
  cp "$config_lua_location" "$config_location/config-example.lua"

  nvim -u "$init_lua_location" --cmd "set runtimepath+=$git_location" --headless \
    +'au User PackerComplete sleep 100m | qall' \
    +PackerInstall

  nvim -u "$init_lua_location" --cmd "set runtimepath+=$git_location" --headless \
    +'au User PackerComplete sleep 100m | qall' \
    +PackerSync

  echo 'Install complete'
}

echo 'Installing pvim'

case "$@" in
  *--reinstall*)
    echo '!!REINSTALL!! Removing all current config due to reinstall...'

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

    echo "Removing $pennyvim_location"
    rm -rf "$pennyvim_location"

    echo "Removing $config_location"
    rm -rf "$config_location"
    ;;
esac

[ -d "$pennyvim_location" ] && echo 'pvim already installed' && exit

if [ -e "$packer_location" ]; then
	echo 'packer is already installed... skipping'
else
	install_packer
fi

if [ -e "$init_lua_location" ]; then
  echo 'pvim already installed. To reinstall provide the --reinstall option'
else
  install_config
fi

