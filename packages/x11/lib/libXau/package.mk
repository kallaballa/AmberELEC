# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libXau"
PKG_VERSION="1.0.12"
PKG_SHA256="74d0e4dfa3d39ad8939e99bda37f5967aba528211076828464d2777d477fc0fb"
PKG_LICENSE="OSS"
PKG_SITE="http://www.x.org"
PKG_URL="http://www.x.org/pub/individual/lib/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-macros xorgproto"
PKG_LONGDESC="X authorization file management libary"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--disable-static --enable-shared --enable-xthreads"
