# ensure neovim is installed

if ! command -v nvim &> /dev/null
then
    echo "Neovim could not be found, please install it first."
    exit
fi


if ! command -v python3 &> /dev/null
then
    echo "Python3 could not be found, it is highly recommended to install it for Neovim support."
else
    EXPORT PYTHON=1    
fi

if ! command -v cargo &> /dev/null
then 
    echo "Cargo could not be found, it is highly recommended to install it for Neovim support."    
fi

if [[ -d "$HOME/.config/nvim" ]]; then
    echo "Backing up existing Neovim configuration to nvim.bak"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
fi

if [[ -d "$HOME/.local/share/nvim" ]]; then
    echo "Backing up existing Neovim data to nvim_data.bak"
    mv "$HOME/.local/share/nvim" "$HOME/.local/share/nvim_data.bak"
fi

# setup
echo "Cloning Neovim configuration..."
git clone https://github.com/SnarkyDeveloper/nvim.git "$HOME/.config/nvim"
echo "Neovim configuration cloned to $HOME/.config/nvim!"

if $PYTHON; then
    echo "Setting up python virtual environment for Neovim..."
    python3 -m venv "$HOME/.config/nvim/lua/snarky/.venv"
    source "$HOME/.config/nvim/lua/snarky/.venv/bin/activate"
    python3 -m pip install --upgrade pip
    python3 -m pip install pyneovim
    deactivate
fi

echo "Setting up Neovim plugins..."
nvim --headless +Lazy! sync +qa

echo "Neovim setup complete!"