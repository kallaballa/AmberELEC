# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="glslang"
PKG_VERSION="15.1.0"
PKG_SHA256="4bdcd8cdb330313f0d4deed7be527b0ac1c115ff272e492853a6e98add61b4bc"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/KhronosGroup/glslang/"
PKG_URL="https://github.com/KhronosGroup/${PKG_NAME}/archive/refs/tags/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Khronos-reference front end for GLSL/ESSL, partial front end for HLSL, and a SPIR-V generator."
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET+=-DENABLE_OPT=0
