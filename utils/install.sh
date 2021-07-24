# Directories
vilua_location="$HOME/.local/share/vilua"
config_location="$HOME/.config/vilua"

# Subdirectories
git_location="$vilua_location/vilua"
packer_location="$vilua_location/site/pack/packer/start/packer.nvim"

# Files
init_lua_location="$vilua_location/vilua/init.lua"
config_lua_location="$vilua_location/vilua/utils/config-example.lua"
bin_location="$vilua_location/vilua/bin/vilua"

install_packer() {
  git clone https://github.com/wbthomason/packer.nvim "$packer_location"
}

install_config() {
  echo 'Cloning Vilua config...'
  mkdir -p $vilua_location

  git clone https://github.com/Peterkmoss/vilua.git "$git_location"

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

echo 'Installing Vilua'

case "$@" in
  *--reinstall*)
    echo '!!REINSTALL!! Removing all current config due to reinstall...'

    echo "5..."
    sleep 1000
    echo "4..."
    sleep 1000
    echo "3..."
    sleep 1000
    echo "2..."
    sleep 1000
    echo "1..."
    sleep 1000

    echo "Removing $vilua_location"
    rm -rf "$vilua_location"

    echo "Removing $config_location"
    rm -rf "$config_location"
    ;;
esac

[ -d "$vilua_location" ] && echo 'Vilua already installed' && exit

if [ -e "$packer_location" ]; then
	echo 'packer is already installed... skipping'
else
	install_packer
fi

if [ -e "$init_lua_location" ]; then
  echo 'Vilua already installed. To reinstall provide the --reinstall option'
else
  install_config
fi

