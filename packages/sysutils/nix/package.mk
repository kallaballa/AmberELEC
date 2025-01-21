# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="nix"
PKG_VERSION="2.25.3"
PKG_ARCH="aarch64"
PKG_URL="http://freebsd.tku.edu.tw/Linux/NixOS/nix/nix-2.25.3/nix-2.25.3-aarch64-linux.tar.xz"
PKG_LICENSE="GPL"
PKG_SITE="http://nixos.org"
PKG_DEPENDS_TARGET="toolchain linux linux-pam"
PKG_LONGDESC="nix package manager"
PKG_TOOLCHAIN="manual"

make_target() {
  return 0;
}

makeinstall_target() {
  set -x
  export NIX_INSTALLER_HOME=/nix
  cd ${PKG_BUILD}
  cp -r ${PKG_DIR}/installer/store ${PKG_DIR}/installer/install . # ${PKG_DIR}/installer/.reginfo .
  sudo mkdir -p /nix
  sudo chown -R ${USER} /nix
  ./install
  mkdir -p ${INSTALL}
#  mkir -p ${SYSROOT_PREFIX}
  sudo mv /nix ${INSTALL}
#  cp -a /nix ${SYSROOT_PREFIX}
  sudo chown -R "${USER}" ${INSTALL}
  sudo chmod -R u+rw ${INSTALL}
}

post_makeinstall_target() {
  sudo chown -R "${USER}" ${INSTALL}
  sudo chmod -R u+rw ${INSTALL}
}

post_install() {
  enable_service nix-copy.service
}
