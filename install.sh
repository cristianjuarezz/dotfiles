#!/bin/bash

set -e

echo "⏫ Actualizando sistema..."
sudo pacman -Syu --noconfirm

echo "📦 Instalando paquetes base..."
sudo pacman -S --needed --noconfirm $(<packages/base.txt)

echo "📦 Instalando yay..."
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
fi

echo "📦 Instalando paquetes AUR..."
yay -S --needed --noconfirm $(<packages/aur.txt)

echo "🌙 Instalando LunarVim..."
bash scripts/lvim_install.sh

echo "🔗 Aplicando configuraciones..."
mkdir -p ~/.config
cp configs/starship.toml ~/.config/starship.toml
cp configs/bash/.bashrc ~/.bashrc

echo "⚙️ Activando servicios..."
bash system/services.sh

echo "🧬 Configurando Git..."
git config --global user.name "Juarez"
git config --global user.email "cristianjuarezdev@gmail.com"

echo "✅ Dotfile instalado correctamente."
