# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="early"
PKG_DEPENDS_TARGET="wireless-regdb kernel-firmware rkbin util-linux libffi make grep wget setuptools rclone libftdi1 libiconv"
PKG_DEPENDS_HOST="configtools:host intltool:host autoconf-archive:host waf:host apache-ant:host luajit:host make:host"
PKG_LONGDESC="Virtual package pinning early host packages"
PKG_TOOLCHAIN="manual"
