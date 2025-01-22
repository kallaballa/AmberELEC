PKG_NAME="freechaf"
PKG_VERSION="cdb8ad6fcecb276761b193650f5ce9ae8b878067"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/FreeChaF"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="retroarch toolchain"
PKG_LONGDESC="FreeChaF is a libretro emulation core for the Fairchild ChannelF / Video Entertainment System designed to be compatible with joypads from the SNES era forward."
PKG_TOOLCHAIN="make"

make_target() {
  make SOURCE_DIR="${SOURCES}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}/src/"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp freechaf_libretro.so ${INSTALL}/usr/lib/libretro/
}
