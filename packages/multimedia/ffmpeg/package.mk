# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ffmpeg"
PKG_VERSION="4.4.1"
PKG_SHA256="eadbad9e9ab30b25f5520fbfde99fae4a92a1ae3c0257a8d68569a4651e30e02"
PKG_LICENSE="GPL-3.0"
PKG_SITE="https://github.com/nyanmisaka/ffmpeg-rockchip/"
PKG_URL="http://ffmpeg.org/releases/ffmpeg-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib bzip2 openssl speex rkmpp mesa waf:host aom dav1d libaacs libamcodec libass libbdplus libbluray libdvbpsi libdvdcss libdvdnav libdvdread libhdhomerun libmpeg2 libva libvdpau rtmpdump x264 openal-soft gmp libgcrypt libopenjpeg pulseaudio xz"
PKG_LONGDESC="FFmpeg is a complete, cross-platform solution to record, convert and stream audio and video."
#PKG_PATCH_DIRS="libreelec v4l2-request v4l2-drmprime"

post_unpack() {
  echo "${PKG_VERSION}" > ${PKG_BUILD}/RELEASE
}

# Dependencies
get_graphicdrivers

  PKG_FFMPEG_HWACCEL="--disable-sdl2 --enable-opengl --enable-hwaccels --enable-rkmpp --enable-libvorbis --enable-libvpx --enable-libwebp --enable-libx264 --enable-libass --enable-gcrypt --enable-gmp --enable-libaom --enable-libbluray --enable-libdav1d --enable-libopus --enable-libpulse --enable-libxcb  --enable-libxcb-shm --enable-openal"
#  PKG_NEED_UNPACK+=" $(get_pkg_directory libdrm)"
#  PKG_FFMPEG_V4L2="--enable-v4l2_m2m --enable-libdrm"

  PKG_DEPENDS_TARGET+=" systemd"
  PKG_NEED_UNPACK+=" $(get_pkg_directory systemd)"

#  PKG_DEPENDS_TARGET+=" libva"
#  PKG_NEED_UNPACK+=" $(get_pkg_directory libva)"
#  PKG_FFMPEG_VAAPI="--enable-vaapi"

  PKG_DEPENDS_TARGET+=" libdrm"
  PKG_NEED_UNPACK+=" $(get_pkg_directory libdrm)"
  PKG_FFMPEG_VAAPI=" --enable-libdrm"

#  PKG_DEPENDS_TARGET+=" libvdpau"
#  PKG_NEED_UNPACK+=" $(get_pkg_directory libvdpau)"
#  PKG_FFMPEG_VDPAU="--enable-vdpau"

#if build_with_debug; then
#  PKG_FFMPEG_DEBUG="--enable-debug --disable-stripping"
#else
#  PKG_FFMPEG_DEBUG="--disable-debug --enable-stripping"
#fi

if target_has_feature neon; then
  PKG_FFMPEG_FPU="--enable-neon"
else
  PKG_FFMPEG_FPU="--disable-neon"
fi

if [ "${TARGET_ARCH}" = "x86_64" ]; then
  PKG_DEPENDS_TARGET+=" nasm:host"
fi

if target_has_feature "(neon|sse)"; then
  PKG_DEPENDS_TARGET+=" dav1d"
  PKG_NEED_UNPACK+=" $(get_pkg_directory dav1d)"
  PKG_FFMPEG_AV1="--enable-libdav1d"
else
  PKG_FFMPEG_AV1="--disable-libdav1d"
fi

pre_configure_target() {
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}
}

if [ "${FFMPEG_TESTING}" = "yes" ]; then
  PKG_FFMPEG_TESTING="--enable-encoder=wrapped_avframe --enable-muxer=null"
  if [ "${PROJECT}" = "RPi" ]; then
    PKG_FFMPEG_TESTING+=" --enable-vout-drm --enable-outdev=vout_drm"
  fi
else
  PKG_FFMPEG_TESTING="--disable-programs"
fi

configure_target() {
  ./configure --prefix="/usr" \
              --cpu="${TARGET_CPU}" \
              --arch="${TARGET_ARCH}" \
              --enable-cross-compile \
              --cross-prefix="${TARGET_PREFIX}" \
              --sysroot="${SYSROOT_PREFIX}" \
              --sysinclude="${SYSROOT_PREFIX}/usr/include" \
              --target-os="linux" \
              --nm="${NM}" \
              --ar="${AR}" \
              --as="${CC}" \
              --cc="${CC}" \
              --ld="${CC}" \
              --host-cc="${HOST_CC}" \
              --host-cflags="${HOST_CFLAGS}" \
              --host-ldflags="${HOST_LDFLAGS}" \
              --extra-cflags="${CFLAGS}" \
              --extra-ldflags="${LDFLAGS}" \
              --extra-libs="${PKG_FFMPEG_LIBS}" \
              --enable-nonfree \
              --disable-static \
              --enable-shared \
              --enable-gpl \
              --enable-version3 \
              --enable-logging \
              --disable-doc \
              ${PKG_FFMPEG_DEBUG} \
              --enable-pic \
              --pkg-config="${TOOLCHAIN}/bin/pkg-config" \
              --enable-optimizations \
              --disable-extra-warnings \
              --enable-avdevice \
              --enable-avcodec \
              --enable-avformat \
              --enable-swscale \
              --enable-postproc \
              --enable-avfilter \
              --disable-devices \
              --enable-pthreads \
              --enable-network \
              --disable-gnutls --enable-openssl \
              --disable-gray \
              --enable-swscale-alpha \
              --disable-small \
              --enable-dct \
              --enable-fft \
              --enable-mdct \
              --enable-rdft \
              --disable-crystalhd \
              ${PKG_FFMPEG_V4L2} \
              ${PKG_FFMPEG_VAAPI} \
              ${PKG_FFMPEG_VDPAU} \
              ${PKG_FFMPEG_RPI} \
              --enable-runtime-cpudetect \
              --disable-hardcoded-tables \
              --disable-encoders \
              --enable-encoder=ac3 \
              --enable-encoder=aac \
              --enable-encoder=wmav2 \
              --enable-encoder=mjpeg \
              --enable-encoder=png \
              ${PKG_FFMPEG_HWACCEL} \
              --disable-muxers \
              --enable-muxer=spdif \
              --enable-muxer=adts \
              --enable-muxer=asf \
              --enable-muxer=ipod \
              --enable-muxer=mpegts \
              --enable-demuxers \
              --enable-parsers \
              --enable-bsfs \
              --enable-protocol=http \
              --disable-indevs \
              --disable-outdevs \
              --enable-filters \
              --disable-avisynth \
              --enable-bzlib \
              --enable-lzma \
              --disable-alsa \
              --disable-frei0r \
              --disable-libopencore-amrnb \
              --disable-libopencore-amrwb \
              --disable-libopencv \
              --disable-libdc1394 \
              --enable-libfreetype \
              --disable-libgsm \
              --disable-libmp3lame \
              --enable-libopenjpeg \
              --disable-librtmp \
              ${PKG_FFMPEG_AV1} \
              --enable-libspeex \
              --disable-libvo-amrwbenc \
              --disable-libxavs \
              --disable-libxvid \
              --enable-zlib \
              --enable-asm \
	      --enable-ffmpeg \
              --disable-altivec \
              ${PKG_FFMPEG_FPU} \
              --disable-symver \
              ${PKG_FFMPEG_TESTING}
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/share/ffmpeg/examples
}
