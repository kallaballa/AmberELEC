# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mesa"
PKG_VERSION="24.3.3"
PKG_SHA256="105afc00a4496fa4d29da74e227085544919ec7c86bd92b0b6e7fcc32c7125f4"
PKG_LICENSE="OSS"
PKG_SITE="http://www.mesa3d.org/"
PKG_URL="https://archive.mesa3d.org/mesa-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain expat wayland Mako:host libdrm pyyaml:host"
PKG_LONGDESC="Mesa is a 3-D graphics library with an API."
PKG_TOOLCHAIN="meson"
#PKG_BUILD_FLAGS="+lto"

get_graphicdrivers

PKG_MESON_OPTS_TARGET="-Dgallium-drivers=panfrost \
                       -Dgallium-extra-hud=false \
                       -Dgallium-nine=false \
                       -Dgallium-opencl=disabled \
                       -Dshader-cache=true \
                       -Dshared-glapi=true \
                       -Dopengl=false \
                       -Dgbm=true \
                       -Degl=true \
		       -Degl-native-platform=wayland
                       -Dglvnd=false \
                       -Dvalgrind=false \
                       -Dlibunwind=false \
                       -Dlmsensors=false \
                       -Dbuild-tests=false \
		       -Dbuild-aco-tests=false \
                       -Dselinux=false \
                       -Dosmesa=false \
		       -Dgles1=true \
		       -Dgles2=true \
		       -Dvulkan-layers=device-select \
		       -Dvulkan-drivers= \
		       -Dlegacy-x11=none"
			

  PKG_DEPENDS_TARGET="${PKG_DEPENDS_TARGET} xorgproto libXext libXdamage libXfixes libXxf86vm libxcb libX11 libxshmfence libXrandr"
  PKG_DEPENDS_TARGET="${PKG_DEPENDS_TARGET} wayland wayland-protocols"
  PKG_MESON_OPTS_TARGET+=" -Dplatforms=wayland,x11 -Dglx=disabled"

if [ "${LLVM_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET="${PKG_DEPENDS_TARGET} elfutils llvm"
  export LLVM_CONFIG="${SYSROOT_PREFIX}/usr/bin/llvm-config-host"
  PKG_MESON_OPTS_TARGET+=" -Dllvm=true"
else
  PKG_MESON_OPTS_TARGET+=" -Dllvm=false"
fi

if [ "${VDPAU_SUPPORT}" = "yes" -a "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET="${PKG_DEPENDS_TARGET} libvdpau"
  PKG_MESON_OPTS_TARGET+=" -Dgallium-vdpau=true"
else
  PKG_MESON_OPTS_TARGET+=" -Dgallium-vdpau=false"
fi

if [ "${VAAPI_SUPPORT}" = "yes" ] && listcontains "${GRAPHIC_DRIVERS}" "(r600|radeonsi)"; then
  PKG_DEPENDS_TARGET="${PKG_DEPENDS_TARGET} libva"
  PKG_MESON_OPTS_TARGET+=" -Dgallium-va=true"
else
  PKG_MESON_OPTS_TARGET+=" -Dgallium-va=false"
fi

if listcontains "${GRAPHIC_DRIVERS}" "vmware"; then
  PKG_MESON_OPTS_TARGET+=" -Dgallium-xa=true"
else
  PKG_MESON_OPTS_TARGET+=" -Dgallium-xa=false"
fi


# Temporary workaround:
# Listed libraries are static, while mesa expects shared ones. This breaks the
# dependency tracking. The following has some ideas on how to address that.
# https://github.com/LibreELEC/LibreELEC.tv/pull/2163
#pre_configure_target() {
#  if [ "${DISPLAYSERVER}" = "x11" ]; then
#    export LIBS="-lxcb-dri3 -lxcb-dri2 -lxcb-xfixes -lxcb-present -lxcb-sync -lxshmfence -lz"
#  fi
#}

post_makeinstall_target() {
#    cp ${PKG_REAL_BUILD}/src/mapi/shared-glapi/libglapi.so.0.0.0 ${INSTALL}/usr/lib/libglapi.so.0.0.0
#    ln -sf ${INSTALL}/usr/lib/libglapi.so.0.0.0 ${INSTALL}/usr/lib/libglapi.so.0
#    ln -sf ${INSTALL}/usr/lib/libglapi.so.0.0.0 ${INSTALL}/usr/lib/libglapi.so

#    cp ${PKG_REAL_BUILD}/src/glx/libGL.so.1.2.0 ${INSTALL}/usr/lib/libGL.so
#    ln -sf ${INSTALL}/usr/lib/libGL.so ${INSTALL}/usr/lib/libGL.so.1
#    ln -sf ${INSTALL}/usr/lib/libGL.so.1 ${INSTALL}/usr/lib/libGL.so.1.2.0
    
#    cp ${PKG_REAL_BUILD}/src/mapi/es1api/libGLESv1_CM.so.1.1.0 ${INSTALL}/usr/lib/libGLESv1_CM.so
#    ln -sf ${INSTALL}/usr/lib/libGLESv1_CM.so ${INSTALL}/usr/lib/libGLESv1_CM.so.1
#    ln -sf ${INSTALL}/usr/lib/libGLESv1_CM.so.1 ${INSTALL}/usr/lib/libGLESv1_CM.so.1.1.0

#    cp ${PKG_REAL_BUILD}/src/mapi/es2api/libGLESv2.so.2.0.0 ${INSTALL}/usr/lib/libGLESv2.so
#    ln -sf ${INSTALL}/usr/lib/libGLESv2.so ${INSTALL}/usr/lib/libGLESv2.so.2
#    ln -sf ${INSTALL}/usr/lib/libGLESv2.so.2 ${INSTALL}/usr/lib/libGLESv2.so.2.0.0

    cp ${PKG_REAL_BUILD}/src/mapi/es2api/libGLESv2.so.2.0.0 ${INSTALL}/usr/lib/libGLESv3.so
    cp ${PKG_REAL_BUILD}/src/mapi/es2api/libGLESv2.so.2.0.0 ${SYSROOT_PREFIX}/usr/lib/libGLESv3.so

    rm -rf ${INSTALL}/usr/lib/libGL.so*
    rm -rf ${SYSROOT_PREFIX}/usr/lib/libGL.so*

    cd ${INSTALL}/usr/lib/
    ln -sf libGLESv3.so libGLESv3.so.3
    ln -sf libGLESv3.so libGLESv3.so.3.0.0

    cd ${SYSROOT_PREFIX}/usr/lib/
    ln -sf libGLESv3.so libGLESv3.so.3
    ln -sf libGLESv3.so libGLESv3.so.3.0.0
}
