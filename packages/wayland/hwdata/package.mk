# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="hwdata"
PKG_VERSION="0.391"
PKG_SHA256="620fe1c22922a3d1bd1062424e9cc6b954acea2f83b72ff0cb45144981cb1975"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/vcrhonek/"
PKG_URL="https://github.com/vcrhonek/hwdata/archive/refs/tags/v0.391.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd"
PKG_LONGDESC="hwdata contains various hardware identification and configuration data, such as the pci.ids and usb.ids databases."
PKG_TOOLCHAIN="configure"

pre_configure_target() {
	cp -r "${PKG_REAL_BUILD}"/../* "${PKG_REAL_BUILD}"
}

