# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libxcrypt"
PKG_VERSION="4.4.36"
PKG_SHA256="7b7abbc89f13f5194211aa6861ed954e4fa3a210a4cb64f7e13dc8cf413e7f2a"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/besser82/libxcrypt"
PKG_URL="https://blueprints.launchpad.net/ubuntu/+archive/primary/+sourcefiles/libxcrypt/1:4.4.36-4build1/${PKG_NAME}_${PKG_VERSION}.orig.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_HOST="autotools:host gcc:bootstrap"
PKG_LONGDESC="Extended crypt library for descrypt, md5crypt, bcrypt, and others"
PKG_TOOLCHAIN="autotools"
PKG_CONFIGURE_OPTS_TARGET="--disable-werror"
PKG_CONFIGURE_OPTS_HOST="--disable-werror"

pre_configure_target() {
#  cd ${PKG_BUILD}
#  ./autogen.sh
  return 0;
}
