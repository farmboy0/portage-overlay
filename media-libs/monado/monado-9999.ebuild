# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://gitlab.freedesktop.org/monado/monado.git"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-r3"
	EXPERIMENTAL="true"
fi

inherit cmake ${GIT_ECLASS}

DESCRIPTION="The open source OpenXR runtime."
HOMEPAGE="https://monado.dev"

if [[ ${PV} == 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="https://gitlab.freedesktop.org/monado/monado/-/archive/v${PV}/monado-v${PV}.tar.bz2 -> ${P}.tar.bz2"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}"
fi

LICENSE="Boost-1.0"
SLOT="0"
IUSE="bluetooth dbus default euroc ffmpeg gles gstreamer hidapi opengl sdl systemd uvc vive vulkan wayland X"

BDEPEND=""
DEPEND="
	dev-cpp/eigen:3
	dev-libs/libbsd
	dev-util/glslang
	media-libs/mesa[egl(+)]
	media-libs/openxr
	virtual/libusb
	virtual/libudev
	dbus? ( sys-apps/dbus )
	euroc? ( media-libs/opencv )
	ffmpeg? ( media-video/ffmpeg )
	gles? ( media-libs/mesa[gles1,gles2] )
	gstreamer? ( media-libs/gstreamer )
	hidapi? ( dev-libs/hidapi )
	opengl? ( virtual/opengl )
	sdl? ( media-libs/libsdl2 )
	systemd? ( sys-apps/systemd )
	uvc? ( media-libs/libuvc )
	vive? (
		media-libs/libsurvive
		sys-libs/zlib
	)
	vulkan? (
		dev-util/vulkan-headers
		media-libs/vulkan-loader
	)
	wayland? (
		dev-libs/wayland
		dev-libs/wayland-protocols
		dev-util/wayland-scanner
	)
	X? (
		x11-libs/libX11
		x11-libs/libXrandr
		x11-libs/libxcb
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DXRT_BUILD_DRIVER_ANDROID=OFF
		-DXRT_BUILD_DRIVER_ARDUINO=$(usex dbus)
		-DXRT_BUILD_DRIVER_DAYDREAM=$(usex dbus)
		-DXRT_BUILD_DRIVER_DEPTHAI=OFF
		-DXRT_BUILD_DRIVER_EUROC=$(usex euroc)
		-DXRT_BUILD_DRIVER_HANDTRACKING=OFF
		-DXRT_BUILD_DRIVER_HDK=ON
		-DXRT_BUILD_DRIVER_HYDRA=ON
		-DXRT_BUILD_DRIVER_ILLIXR=OFF
		-DXRT_BUILD_DRIVER_NS=ON
		-DXRT_BUILD_DRIVER_OHMD=OFF
		-DXRT_BUILD_DRIVER_OPENGLOVES=$(usex bluetooth)
		-DXRT_BUILD_DRIVER_PSMV=ON
		-DXRT_BUILD_DRIVER_PSVR=$(usex hidapi)
		-DXRT_BUILD_DRIVER_QWERTY=$(usex sdl)
		-DXRT_BUILD_DRIVER_REALSENSE=OFF
		-DXRT_BUILD_DRIVER_REMOTE=ON
		-DXRT_BUILD_DRIVER_RIFT_S=$(usex hidapi)
		-DXRT_BUILD_DRIVER_SIMULATED=ON
		-DXRT_BUILD_DRIVER_SIMULAVR=OFF
		-DXRT_BUILD_DRIVER_SURVIVE=$(usex vive)
		-DXRT_BUILD_DRIVER_TWRAP=ON
		-DXRT_BUILD_DRIVER_ULV2=OFF
		-DXRT_BUILD_DRIVER_VF=$(usex gstreamer)
		-DXRT_BUILD_DRIVER_VIVE=$(usex vive)
		-DXRT_BUILD_DRIVER_WMR=ON

		-DXRT_BUILD_SAMPLES=OFF

		-DXRT_HAVE_BLUETOOTH=$(usex bluetooth)
		-DXRT_HAVE_DBUS=$(usex dbus)
		-DXRT_HAVE_EGL=ON
		-DXRT_HAVE_FFMPEG=$(usex ffmpeg)
		-DXRT_HAVE_GST=$(usex gstreamer)
		-DXRT_HAVE_HIDAPI=$(usex hidapi)
		-DXRT_HAVE_JPEG=ON
		-DXRT_HAVE_LIBBSD=ON
		-DXRT_HAVE_LIBUDEV=ON
		-DXRT_HAVE_LIBUSB=ON
		-DXRT_HAVE_LIBUVC=$(usex uvc)
		-DXRT_HAVE_ONNXRUNTIME=OFF
		-DXRT_HAVE_OPENCV=$(usex euroc)
		-DXRT_HAVE_OPENGL=$(usex opengl)
		-DXRT_HAVE_OPENGL_GLX=$(usex opengl && usex X)
		-DXRT_HAVE_OPENGLES=$(usex gles)
		-DXRT_HAVE_PERCETTO=OFF
		-DXRT_HAVE_REALSENSE=OFF
		-DXRT_HAVE_SDL2=$(usex sdl)
		-DXRT_HAVE_SYSTEM_CJSON=OFF
		-DXRT_HAVE_SYSTEMD=$(usex systemd)
		-DXRT_HAVE_TRACY=OFF
		-DXRT_HAVE_VULKAN=$(usex vulkan)
		-DXRT_HAVE_WAYLAND=$(usex wayland)
		-DXRT_HAVE_WAYLAND_DIRECT=$(usex wayland)
		-DXRT_HAVE_XCB=$(usex X)
		-DXRT_HAVE_XLIB=$(usex X)
		-DXRT_HAVE_XRANDR=$(usex X)

		-DXRT_INSTALL_SYSTEMD_UNIT_FILES=$(usex systemd)

		-DXRT_OPENXR_INSTALL_ACTIVE_RUNTIME=$(usex default)
	)

	cmake_src_configure
}
