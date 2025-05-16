#!/bin/bash

set -e

echo "⏫ Actualizando sistema..."
sudo pacman -Syu --noconfirm

echo "📦 Instalando paquetes base..."
sudo pacman -S --needed --noconfirm $(<packages/base.txt)

echo "⚙️ Preparando entorno para compilar 'paru' desde AUR..."

# Asegurar dependencias necesarias
sudo pacman -S --needed --noconfirm base-devel fakeroot openssl openssl-1.1 pkgconf

# Exportar variables de entorno para compilar openssl-sys si hiciera falta
export OPENSSL_DIR="/usr"
export OPENSSL_LIB_DIR="/usr/lib"
export OPENSSL_INCLUDE_DIR="/usr/include"

# Clonar e instalar paru solo si no está instalado
if ! command -v paru &> /dev/null; then
  echo "📦 Instalando 'paru' desde AUR..."
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  cd /tmp/paru
  makepkg -si --noconfirm
  cd -
  rm -rf /tmp/paru
else
  echo "✅ 'paru' ya está instalado."
fi

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
