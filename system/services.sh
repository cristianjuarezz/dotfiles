#!/bin/bash
echo "🛠️ Habilitando Docker..."
sudo systemctl enable --now docker

echo "🛡️ OpenVPN no se activa por defecto (requiere archivos .ovpn)"
