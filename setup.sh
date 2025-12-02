#!/usr/bin/env bash
set -e

printf "\nChecking dependencies...\n"

# nvim
if ! command -v nvim >/dev/null 2>&1; then
    printf "❌ Neovim not found. Please install it first.\n"
    exit 1
fi

# py
if command -v python3 >/dev/null 2>&1; then
    PYTHON_SUPPORT=1
else
    PYTHON_SUPPORT=0
    printf "⚠️  Python3 not found (optional but recommended).\n"
fi

# cargo
if ! command -v cargo >/dev/null 2>&1; then
    printf "⚠️  Cargo not found (optional but recommended).\n"
fi

printf "✔️  Dependency check complete.\n\n"

# ensure no accidental deletion
backup() {
    local src="$1"
    local dest="$2"

    if [[ -d "$src" ]]; then
        mv "$src" "$dest"
        printf "Backed up %s → %s\n" "$src" "$dest"
    fi
}

printf "Backing up any existing Neovim config...\n"
backup "$HOME/.config/nvim"        "$HOME/.config/nvim.bak"
backup "$HOME/.local/share/nvim"   "$HOME/.local/share/nvim_data.bak"

# cloning...
printf "Cloning Neovim configuration...\n"
git clone -q https://github.com/SnarkyDeveloper/nvim.git "$HOME/.config/nvim"
printf "✔️  Configuration installed.\n\n"

# venv
if [[ $PYTHON_SUPPORT -eq 1 ]]; then
    printf "Setting up Python virtual environment...\n"
    python3 -m venv "$HOME/.config/nvim/lua/snarky/.venv"
    (
        source "$HOME/.config/nvim/lua/snarky/.venv/bin/activate"
        python3 -m pip install -q --upgrade pip
        python3 -m pip install -q pynvim
    )
    printf "✔️  Python support installed.\n\n"
fi

# quietly install
printf "Installing Neovim plugins (this may take a moment)...\n"
nvim --headless "+Lazy! sync" +qa >/dev/null 2>&1
printf "✔️  Plugins installed.\n\n"

printf "🎉 Neovim setup complete!\n"
