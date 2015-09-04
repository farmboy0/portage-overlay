# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="A tool for tracing, analyzing, and debugging graphics APIs"
HOMEPAGE="https://github.com/apitrace/apitrace"

IUSE="cli egl qt5"
KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="MIT"

EGIT_REPO_URI="https://github.com/apitrace/apitrace"
PYTHON_COMPAT=( python2_7 )

inherit cmake-multilib eutils python-single-r1 git-r3

RDEPEND="app-arch/snappy[${MULTILIB_USEDEP}]
	media-libs/libpng:0=
	sys-libs/zlib
	sys-process/procps[${MULTILIB_USEDEP}]
	media-libs/mesa[egl?]
	egl? ( || (
		>=media-libs/mesa-8.0[gles1,gles2]
		<media-libs/mesa-8.0[gles]
	) )
	x11-libs/libX11[${MULTILIB_USEDEP}]
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwebkit:5
		>=dev-libs/qjson-0.5
	)"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-4.0-system-libs.patch
	"${FILESDIR}"/${PN}-4.0-disable-cli.patch
	"${FILESDIR}"/${PN}-4.0-disable-multiarch.patch
)

src_configure() {
	my_configure() {
		mycmakeargs=(
			$(cmake-utils_use_enable egl EGL)
			-DDOC_INSTALL_DIR="${D}usr/share/doc/${PF}"
		)
		if multilib_build_binaries ; then
			mycmakeargs+=(
				$(cmake-utils_use_enable cli CLI)
				$(cmake-utils_use_enable qt5 GUI)
			)
		else
			mycmakeargs+=(
				-DENABLE_CLI=OFF
				-DENABLE_GUI=OFF
			)
		fi
	cmake-utils_src_configure
	}

	multilib_parallel_foreach_abi my_configure
}

src_compile() {
	cmake-multilib_src_compile
}

src_install() {
	cmake-multilib_src_install

	dodoc docs/FORMAT.markdown docs/VMWX_map_buffer_debug.txt
}

multilib_src_install() {
	cmake-utils_src_install "${_cmake_args[@]}"

	dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so
	dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so.1
	dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so.1.2
}
