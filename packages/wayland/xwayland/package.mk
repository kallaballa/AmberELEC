# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xwayland"
PKG_VERSION="24.1.4"
PKG_SHA256="d96a78dbab819f55750173444444995b5031ebdcc15b77afebbd8dbc02af34f4"
PKG_LICENSE="OSS"
PKG_SITE="https://www.x.org/"
PKG_URL="https://www.x.org/archive/individual/xserver/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain wayland wayland-protocols libxcvt libepoxy freetype linux zlib"
PKG_LONGDESC="an Xorg server running on top of the wayland servers"
PKG_TOOLCHAIN="meson"
PKG_MESON_OPTS_TARGET="-Dglamor=true -Ddrm=true -Ddri3=true -Dglx=true"

post_makeinstall_target() {
    rm -rf ${SYSROOT_PREFIX}/usr/lib/liblibglxvnd.a
    cp ${PKG_REAL_BUILD}/glx/liblibglxvnd.a ${SYSROOT_PREFIX}/usr/lib/liblibglxvnd.a

    rm -rf ${INSTALL}/usr/lib/liblibglxvnd.a
    cp ${PKG_REAL_BUILD}/glx/liblibglxvnd.a ${INSTALL}/usr/lib/liblibglxvnd.a

    rm -rf ${SYSROOT_PREFIX}/usr/lib/liblibxserver_glx.a
    cp ${PKG_REAL_BUILD}/glx/liblibxserver_glx.a ${SYSROOT_PREFIX}/usr/lib/liblibxserver_glx.a

    rm -rf ${INSTALL}/usr/lib/liblibxserver_glx.a
    cp ${PKG_REAL_BUILD}/glx/liblibxserver_glx.a ${INSTALL}/usr/lib/liblibxserver_glx.a
}
