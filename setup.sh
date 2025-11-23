# ensure neovim is installed

if ! command -v nvim &> /dev/null
then
    echo "Neovim could not be found, please install it first."
    exit
fi

if [[ -d "$HOME/.config/nvim" ]]; then
    echo "Backing up existing Neovim configuration to nvim.bak"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
fi


# setup
echo "Setting up python virtual environment for Neovim..."
python3 -m venv "$HOME/.config/nvim/lua/snarky/.venv"
source "$HOME/.config/nvim/lua/snarky/.venv/bin/activate"
python3 -m pip install --upgrade pip
python3 -m pip install pyneovim