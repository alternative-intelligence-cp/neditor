#!/bin/bash
set -e

VERSION="1.0.0"
RPM_DIR="$(pwd)/rpmbuild"

echo "Building Neditor for RPM packaging..."
/home/randy/Workspace/REPOS/nitpick-build/build/npkbld build neditor

echo "Preparing RPM build directory structure..."
mkdir -p "$RPM_DIR"/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
mkdir -p "$RPM_DIR/BUILD/neditor-$VERSION"

# Copy sources to BUILD
cp .nitpick_make/build/neditor "$RPM_DIR/BUILD/neditor-$VERSION/"
cp docs/neditor.1 "$RPM_DIR/BUILD/neditor-$VERSION/"
cp assets/neditor.desktop "$RPM_DIR/BUILD/neditor-$VERSION/"

# Create SPEC file
cat << EOF > "$RPM_DIR/SPECS/neditor.spec"
Name:           neditor
Version:        $VERSION
Release:        1%{?dist}
Summary:        Advanced TUI text editor written completely in Nitpick

License:        AGPLv3
URL:            https://example.com/neditor
BuildArch:      x86_64

%description
Neditor is an advanced TUI (Text User Interface) text editor written completely in Nitpick. It aims to provide modal editing with modern features like syntax highlighting, an extensible plugin system, and fast rendering, entirely inside a terminal environment.

%prep
# Nothing to prep, we copy built files manually.

%build
# Nothing to build, binaries are already built by npkbld.

%install
rm -rf \$RPM_BUILD_ROOT
mkdir -p \$RPM_BUILD_ROOT/usr/bin
mkdir -p \$RPM_BUILD_ROOT/usr/share/man/man1
mkdir -p \$RPM_BUILD_ROOT/usr/share/applications

cp %{_builddir}/neditor-%{version}/neditor \$RPM_BUILD_ROOT/usr/bin/
cp %{_builddir}/neditor-%{version}/neditor.1 \$RPM_BUILD_ROOT/usr/share/man/man1/
cp %{_builddir}/neditor-%{version}/neditor.desktop \$RPM_BUILD_ROOT/usr/share/applications/

%files
/usr/bin/neditor
/usr/share/man/man1/neditor.1*
/usr/share/applications/neditor.desktop

%changelog
* Tue Jun 16 2026 Randy <randy@example.com> - $VERSION-1
- Initial RPM release
EOF

echo "Building RPM package..."
rpmbuild --define "_topdir $RPM_DIR" -bb "$RPM_DIR/SPECS/neditor.spec"

echo "Success! Packages located in $RPM_DIR/RPMS/x86_64/"
