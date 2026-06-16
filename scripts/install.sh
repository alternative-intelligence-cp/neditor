#!/bin/bash
set -e

echo "Building Neditor..."
/home/randy/Workspace/REPOS/nitpick-build/build/npkbld build neditor

echo "Installing Neditor..."
sudo mkdir -p /usr/local/bin
sudo mkdir -p /usr/local/share/man/man1
sudo mkdir -p /usr/local/share/applications

sudo cp .nitpick_make/build/neditor /usr/local/bin/
sudo cp docs/neditor.1 /usr/local/share/man/man1/
sudo cp assets/neditor.desktop /usr/local/share/applications/

echo "Updating desktop database..."
sudo update-desktop-database /usr/local/share/applications || true

echo "Installation complete! You can now run 'neditor' from the terminal or launcher."
