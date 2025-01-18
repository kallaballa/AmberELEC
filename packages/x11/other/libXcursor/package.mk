# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libXcursor"
PKG_VERSION="1.2.3"
PKG_SHA256="fde9402dd4cfe79da71e2d96bb980afc5e6ff4f8a7d74c159e1966afb2b2c2c0"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-macros font-util xorgproto libpciaccess libX11 libXfont2 libXinerama libxshmfence libxkbfile openssl freetype pixman systemd xorg-launch-helper libXfixes libXrender"
PKG_LONGDESC="Xlib-based Cursor management library"
PKG_TOOLCHAIN="configure"

post_makeinstall_target() {
    mkdir -p ${SYSROOT_PREFIX}/usr/lib/pkgconfig
    cp xcursor.pc ${SYSROOT_PREFIX}/usr/lib/pkgconfig
}
