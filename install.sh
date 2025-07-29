#!/bin/bash

set -e

VERSION="v0.12.2"
FILENAME="NoiseTorch_x64.tgz"
DOWNLOAD_URL="https://github.com/noisetorch/NoiseTorch/releases/download/$VERSION/$FILENAME"
INSTALL_DIR="$HOME/bin"
ICON_DIR="$HOME/.local/share/icons"
DESKTOP_DIR="$HOME/.local/share/applications"

# Step 1: Download NoiseTorch
echo "🔽 Downloading NoiseTorch..."
mkdir -p "$INSTALL_DIR"
curl -L -A "Mozilla/5.0" "$DOWNLOAD_URL" -o "$HOME/$FILENAME"

# Step 2: Extract
echo "📦 Extracting to $INSTALL_DIR..."
tar -xzf "$HOME/$FILENAME" -C "$INSTALL_DIR"
rm "$HOME/$FILENAME"

# Step 3: Add to PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "🔧 Adding $INSTALL_DIR to PATH..."
    SHELL_RC="$HOME/.bashrc"
    [[ "$SHELL" == *"zsh" ]] && SHELL_RC="$HOME/.zshrc"
    echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$SHELL_RC"
    echo "✅ Added to $SHELL_RC (restart your terminal to apply)"
fi

# Step 4: Install icon
echo "🖼️ Setting up icon..."
mkdir -p "$ICON_DIR"
cp assets/noisetorch.png "$ICON_DIR/noisetorch.png"

# Step 5: Create .desktop file
echo "🖥️ Creating desktop entry..."
mkdir -p "$DESKTOP_DIR"
cat <<EOF > "$DESKTOP_DIR/noisetorch.desktop"
[Desktop Entry]
Name=NoiseTorch
Comment=Real-time microphone noise suppression
Exec=$INSTALL_DIR/noisetorch
Icon=$ICON_DIR/noisetorch.png
Terminal=false
Type=Application
Categories=Audio;Utility;
EOF

chmod +x "$DESKTOP_DIR/noisetorch.desktop"

echo "✅ Done! You can now launch NoiseTorch from your application menu."
