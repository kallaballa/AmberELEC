# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mesa"
PKG_VERSION="24.3.3"
PKG_SHA256="105afc00a4496fa4d29da74e227085544919ec7c86bd92b0b6e7fcc32c7125f4"
PKG_LICENSE="OSS"
PKG_SITE="http://www.mesa3d.org/"
PKG_URL="https://archive.mesa3d.org/mesa-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain expat Mako:host libdrm pyyaml:host"
PKG_LONGDESC="Mesa is a 3-D graphics library with an API."
PKG_TOOLCHAIN="meson"
#PKG_BUILD_FLAGS="+lto"

get_graphicdrivers

PKG_MESON_OPTS_TARGET="-Dgallium-drivers=panfrost \
                       -Dshader-cache=true \
                       -Dshared-glapi=true \
		       -Dtools=panfrost \
                       -Dopengl=true \
                       -Dgbm=true \
                       -Degl=true \
                       -Dglvnd=false \
                       -Dvalgrind=false \
                       -Dlibunwind=false \
                       -Dlmsensors=false \
                       -Dbuild-tests=false \
		       -Dbuild-aco-tests=false \
                       -Dselinux=false \
                       -Dosmesa=false \
		       -Dgles1=false \
		       -Dgles2=true \
		       -Dvulkan-drivers=panfrost \
		       -Dglx-direct=true \
                      -Dlegacy-x11=dri2"
			

  PKG_DEPENDS_TARGET="${PKG_DEPENDS_TARGET} wayland wayland-protocols xorgproto libxcvt libXdmcp freetype linux libXau zlib libXfixes libxshmfence libXxf86vm libXrandr"
  PKG_MESON_OPTS_TARGET+=" -Dplatforms=wayland,x11 -Dglx=dri"

#  PKG_DEPENDS_TARGET="${PKG_DEPENDS_TARGET} elfutils llvm"
#  export LLVM_CONFIG="${SYSROOT_PREFIX}/usr/bin/llvm-config-host"
  PKG_MESON_OPTS_TARGET+=" -Dllvm=false"
  PKG_MESON_OPTS_TARGET+=" -Dgallium-vdpau=false"
  PKG_MESON_OPTS_TARGET+=" -Dgallium-va=false"
  PKG_MESON_OPTS_TARGET+=" -Dgallium-xa=false"


post_makeinstall_target() {
    mkdir -p  ${SYSROOT_PREFIX}/usr/include/linux/
    cp ${PKG_BUILD}/include/drm-uapi/sync_file.h ${SYSROOT_PREFIX}/usr/include/linux/

    rm -rf ${SYSROOT_PREFIX}/usr/lib/libGLESv*.so*
    rm -rf ${SYSROOT_PREFIX}/usr/lib/libGL.so*

    cp ${PKG_REAL_BUILD}/src/mapi/es2api/libGLESv2.so.2.0.0 ${SYSROOT_PREFIX}/usr/lib/libGLESv3.so
    cp ${PKG_REAL_BUILD}/src/glx/libGL.so.1.2.0 ${SYSROOT_PREFIX}/usr/lib/libGL.so

    rm -rf ${INSTALL}/usr/lib/libGLESv*.so*
    rm -rf ${INSTALL}/usr/lib/libGL.so*

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
}
