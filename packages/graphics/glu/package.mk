# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="glu"
PKG_VERSION="9.0.3"
PKG_SHA256="38044ee4f255578165a54eaeb089b67fb64f7f7c0ce5fa690cd47c9df10b263c"
PKG_LICENSE="OSS"
PKG_SITE="http://cgit.freedesktop.org/mesa/glu/"
PKG_URL="https://gitlab.freedesktop.org/mesa/glu/-/archive/glu-9.0.3/glu-glu-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain mesa glibc"
PKG_LONGDESC="libglu is the The OpenGL utility library"
PKG_TOOLCHAIN="meson"

pre_configure_target() {
  export CFLAGS="${CFLAGS} -Wno-error"
  export CXXFLAGS="${CFLAGS} -Wno-error"
}
