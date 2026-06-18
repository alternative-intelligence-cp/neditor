Name:           neditor
Version:        1.0.0
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
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/usr/bin
mkdir -p $RPM_BUILD_ROOT/usr/share/man/man1
mkdir -p $RPM_BUILD_ROOT/usr/share/applications

cp %{_builddir}/neditor-%{version}/neditor $RPM_BUILD_ROOT/usr/bin/
cp %{_builddir}/neditor-%{version}/neditor.1 $RPM_BUILD_ROOT/usr/share/man/man1/
cp %{_builddir}/neditor-%{version}/neditor.desktop $RPM_BUILD_ROOT/usr/share/applications/

%files
/usr/bin/neditor
/usr/share/man/man1/neditor.1*
/usr/share/applications/neditor.desktop

%changelog
* Tue Jun 16 2026 Randy <randy@example.com> - 1.0.0-1
- Initial RPM release
