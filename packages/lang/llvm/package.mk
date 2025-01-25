# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="llvm"
PKG_VERSION="e21dc4bd5474d04b8e62d7331362edcc5648d7e5"
PKG_SHA256="408d11708643ea826f519ff79761fcdfc12d641a2510229eec459e72f8163020"
PKG_GIT_CLONE_BRANCH="llvmorg-19.1.6"
PKG_GIT_CLONE_SINGLE=yes
PKG_LICENSE="Apache-2.0"
PKG_SITE="http://llvm.org/"
PKG_URL="https://github.com/llvm/llvm-project.git"
PKG_DEPENDS_HOST="toolchain:host zlib:host"
PKG_DEPENDS_TARGET="toolchain zlib llvm:host"
PKG_LONGDESC="Low-Level Virtual Machine (LLVM) is a compiler infrastructure."
PKG_TOOLCHAIN="cmake"
PKG_CMAKE_OPTS_HOST="-DLLVM_TARGETS_TO_BUILD=AArch64 -DLLVM_ENABLE_PROJECTS=llvm;clang -DLLVM_INSTALL_UTILS=ON"
PKG_CMAKE_OPTS_TARGET="-DLLVM_TARGETS_TO_BUILD=AArch64 -DLLVM_ENABLE_PROJECTS=clang;libclc -DLLVM_INSTALL_UTILS=ON"
PKG_BUILD_FLAGS="+local-cc"

configure_host() {
  CXXFLAGS+=" -DLLVM_CONFIG_EXEC_PREFIX=\\\"${SYSROOT_PREFIX}\\\""
  cmake -S llvm -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=${SYSROOT_PREFIX}/usr ${PKG_CMAKE_OPTS_TARGET}
}

configure_target() {
  CXXFLAGS+=" -DLLVM_CONFIG_EXEC_PREFIX=\\\"${SYSROOT_PREFIX}\\\""
  cmake -S llvm -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=${SYSROOT_PREFIX}/usr ${PKG_CMAKE_OPTS_TARGET}
}

makeinstall_host() {
  ninja ${NINJA_OPTS} install
}

makeinstall_target() {
  ninja ${NINJA_OPTS} install
}
