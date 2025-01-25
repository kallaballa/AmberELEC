# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mesa"
PKG_VERSION="24.3.4"
PKG_SHA256="e641ae27191d387599219694560d221b7feaa91c900bcec46bf444218ed66025"
PKG_LICENSE="OSS"
PKG_SITE="http://www.mesa3d.org/"
PKG_URL="https://archive.mesa3d.org/mesa-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain expat Mako:host libdrm pyyaml:host zstd glslang:host spirv-tools:host luajit elfutils"
PKG_LONGDESC="Mesa is a 3-D graphics library with an API."
PKG_TOOLCHAIN="meson"
#PKG_BUILD_FLAGS="+lto"

get_graphicdrivers

PKG_MESON_OPTS_TARGET="-Dgallium-drivers=panfrost \
		       -Dgallium-extra-hud=true \
		       -Degl-native-platform=wayland \
		       -Dvulkan-drivers=panfrost \
		       -Dopencl-spirv=true \
		       -Dtools=panfrost \
		       -Dbuild-tests=true \
		       -Dbuild-aco-tests=false \
		       -Dllvm=false \
		       -Dlegacy-x11=none"
#      -Dvideo-codecs=all \
#      -Dgallium-opencl=icd \

			

  PKG_DEPENDS_TARGET="${PKG_DEPENDS_TARGET} wayland wayland-protocols libXrandr libXrender libXxf86vm libXdamage libXext libXfixes xkbcomp xorgproto libXdmcp libXau libXfont2 libxshmfence pixman libxcb xcb-proto xcb-util-keysym"

pre_configure_target() {
  export PKG_CONFIG_PATH="${SYSROOT_PREFIX}/share/pkgconfig/:${PKG_CONFIG_PATH}"
  export LLVM_CONFIG="${SYSROOT_PREFIX}/bin/llvm-config"
}

post_makeinstall_target() {
    mkdir -p  ${SYSROOT_PREFIX}/usr/include/linux/
    cp ${PKG_BUILD}/include/drm-uapi/sync_file.h ${SYSROOT_PREFIX}/usr/include/linux/

    rm -rf ${SYSROOT_PREFIX}/usr/lib/libGLESv*.so*
    rm -rf ${SYSROOT_PREFIX}/usr/lib/libGL.so*

    cp ${PKG_REAL_BUILD}/src/mapi/es2api/libGLESv2.so.2.0.0 ${SYSROOT_PREFIX}/usr/lib/libGLESv2.so
    cp ${PKG_REAL_BUILD}/src/mapi/es2api/libGLESv2.so.2.0.0 ${SYSROOT_PREFIX}/usr/lib/libGLESv3.so
    cp ${PKG_REAL_BUILD}/src/glx/libGL.so.1.2.0 ${SYSROOT_PREFIX}/usr/lib/libGL.so

    rm -rf ${INSTALL}/usr/lib/libGLESv*.so*
    rm -rf ${INSTALL}/usr/lib/libGL.so*

    cp ${PKG_REAL_BUILD}/src/mapi/es2api/libGLESv2.so.2.0.0 ${INSTALL}/usr/lib/libGLESv2.so
    cp ${PKG_REAL_BUILD}/src/mapi/es2api/libGLESv2.so.2.0.0 ${INSTALL}/usr/lib/libGLESv3.so
    cp ${PKG_REAL_BUILD}/src/glx/libGL.so.1.2.0 ${INSTALL}/usr/lib/libGL.so

    cd ${INSTALL}/usr/lib/
    ln -sf libGL.so libGL.so.1
    ln -sf libGL.so libGL.so.1.2.0

    cd ${SYSROOT_PREFIX}/usr/lib/
    ln -sf libGL.so libGL.so.1
    ln -sf libGL.so libGL.so.1.2.0

    cd ${INSTALL}/usr/lib/
    ln -sf libGLESv3.so libGLESv3.so.3
    ln -sf libGLESv3.so libGLESv3.so.3.0.0

   cd ${SYSROOT_PREFIX}/usr/lib/
   ln -sf libGLESv3.so libGLESv3.so.3
   ln -sf libGLESv3.so libGLESv3.so.3.0.0

   cd ${INSTALL}/usr/lib/
   ln -sf libGLESv2.so libGLESv2.so.2
   ln -sf libGLESv2.so libGLESv2.so.2.0.0

   cd ${SYSROOT_PREFIX}/usr/lib/
   ln -sf libGLESv2.so libGLESv2.so.2
   ln -sf libGLESv2.so libGLESv2.so.2.0.0
}
