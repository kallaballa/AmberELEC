# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="weston"
PKG_VERSION="14.0.1"
PKG_SHA256="a8150505b126a59df781fe8c30c8e6f87da7013e179039eb844a5bbbcc7c79b3"
PKG_LICENSE="OSS"
PKG_SITE="https://wayland.freedesktop.org/"
PKG_URL="https://gitlab.freedesktop.org/wayland/weston/-/releases/14.0.1/downloads/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain wayland-protocols libdrm librga libxkbcommon libinput cairo linux-pam libjpeg-turbo dbus libseat hwdata libXcursor libdisplay-info xwayland"
PKG_LONGDESC="Reference implementation of a Wayland compositor"
PKG_TOOLCHAIN="meson"
PKG_MESON_OPTS_TARGET="-Dcolor-management-lcms=false -Dbackend-drm=true -Dbackend-drm-screencast-vaapi=false -Dbackend-pipewire=false -Dbackend-vnc=false -Dbackend-x11=false -Dbackend-default=drm -Dremoting=false -Dpipewire=false -Dbackend-rdp=false -Ddoc=false -Ddemo-clients=false -Dtests=false -Drenderer-gl=false -Dsimple-clients=damage,im,shm,touch,dmabuf-v4l"

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/weston
    cp ${PKG_DIR}/scripts/weston-config ${INSTALL}/usr/lib/weston

  mkdir -p ${INSTALL}/usr/share/weston
    cp ${PKG_DIR}/config/weston.ini ${INSTALL}/usr/share/weston

  rm -r ${INSTALL}/usr/share/wayland-sessions
  rm -r ${INSTALL}/usr/lib/weston-simple-im
}

post_install() {
  enable_service weston.service
}
