# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xz"
PKG_VERSION="5.4.6"
PKG_SHA256="aeba3e03bf8140ddedf62a0a367158340520f6b384f75ca6045ccc6c0d43fd5c"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/tukaani-project/xz"
PKG_URL="${PKG_SITE}/releases/download/v${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="autotools:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A free general-purpose data compression software with high compression ratio."
PKG_BUILD_FLAGS="+local-cc +pic +pic:host"
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_HOST="--disable-shared --enable-static \
                         --disable-doc \
                         --enable-lzmadec \
                         --enable-lzmainfo \
                         --enable-lzma-links \
                         --disable-nls \
                         --disable-scripts \
                         --enable-symbol-versions=no"

post_makeinstall_target() {
  return 0;
}
