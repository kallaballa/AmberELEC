#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wayland"
PKG_VERSION="1.23.0"
PKG_SHA256="05b3e1574d3e67626b5974f862f36b5b427c7ceeb965cb36a4e6c2d342e45ab2"
PKG_LICENSE="OSS"
PKG_SITE="https://wayland.freedesktop.org/"
PKG_URL="https://gitlab.freedesktop.org/wayland/wayland/-/releases/1.23.0/downloads/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libxml2 wayland:bootstrap libmali"
PKG_DEPENDS_HOST="libffi:host expat:host libxml2:host wayland:bootstrap"
PKG_LONGDESC="a display server protocol"
PKG_TOOLCHAIN="meson"
PKG_MESON_OPTS_BOOTSTRAP="-Ddocumentation=false -Dtests=false -Dscanner=true"
PKG_MESON_OPTS_HOST="-Ddocumentation=false -Dtests=false -Dscanner=false"
PKG_MESON_OPTS_TARGET="-Ddocumentation=false -Dtests=false -Ddtd_validation=false -Dscanner=false"

pre_configure_host() {
  cat > "${SYSROOT_PREFIX}"/usr/lib/pkgconfig/wayland-scanner.pc << EOF
prefix="${TOOLCHAIN}"
includedir="${TOOLCHAIN}"/include

datarootdir="${TOOLCHAIN}"/share
pkgdatadir="${TOOLCHAIN}"/share/wayland
bindir="${TOOLCHAIN}"/bin
wayland_scanner="${TOOLCHAIN}"/bin/wayland-scanner

Name: Wayland Scanner
Description: Wayland scanner
Version: 1.23.0
Cflags: -I${includedir}
EOF
}

pre_configure_target() {
  cat > "${SYSROOT_PREFIX}"/usr/lib/pkgconfig/wayland-scanner.pc << EOF
prefix="${TOOLCHAIN}"
includedir="${TOOLCHAIN}"/include

datarootdir="${TOOLCHAIN}"/share
pkgdatadir="${TOOLCHAIN}"/share/wayland
bindir="${TOOLCHAIN}"/bin
wayland_scanner="${TOOLCHAIN}"/bin/wayland-scanner

Name: Wayland Scanner
Description: Wayland scanner
Version: 1.23.0
Cflags: -I${includedir}
EOF
}

post_makeinstall_bootstrap() {
  cp "${TOOLCHAIN}"/lib/pkgconfig/wayland-scanner.pc  ${TOOLCHAIN}/aarch64-libreelec-linux-gnueabi/sysroot/usr/lib/pkgconfig/wayland-scanner.pc
}
