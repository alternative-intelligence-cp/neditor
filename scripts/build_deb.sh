#!/bin/bash
set -e

VERSION="1.0.0"
ARCH="amd64"
PKG_NAME="neditor_${VERSION}_${ARCH}"

echo "Building Neditor for Debian packaging..."
/home/randy/Workspace/REPOS/nitpick-build/build/npkbld build neditor

echo "Preparing DEB staging directory..."
mkdir -p "$PKG_NAME/DEBIAN"
mkdir -p "$PKG_NAME/usr/bin"
mkdir -p "$PKG_NAME/usr/share/man/man1"
mkdir -p "$PKG_NAME/usr/share/applications"

# Copy files
cp .nitpick_make/build/neditor "$PKG_NAME/usr/bin/"
cp docs/neditor.1 "$PKG_NAME/usr/share/man/man1/"
cp assets/neditor.desktop "$PKG_NAME/usr/share/applications/"

# Create control file
cat << EOF > "$PKG_NAME/DEBIAN/control"
Package: neditor
Version: $VERSION
Section: editors
Priority: optional
Architecture: $ARCH
Maintainer: Randy <randy@example.com>
Description: Advanced TUI text editor written completely in Nitpick.
 Neditor aims to provide modal editing with modern features like
 syntax highlighting, an extensible plugin system, and fast
 rendering, entirely inside a terminal environment.
EOF

echo "Building DEB package..."
dpkg-deb --build "$PKG_NAME"

echo "Success! Created $PKG_NAME.deb"
# Clean up staging directory
rm -rf "$PKG_NAME"
