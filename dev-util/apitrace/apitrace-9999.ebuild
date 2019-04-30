# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"
PYTHON_COMPAT=( python3_{1,2,3,4,5,6,7} )
EGIT_REPO_URI="https://github.com/apitrace/apitrace"

inherit cmake-multilib eutils python-any-r1 git-r3

DESCRIPTION="A tool for tracing, analyzing, and debugging graphics APIs"
HOMEPAGE="https://github.com/apitrace/apitrace"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cli egl qt5"

RDEPEND="${PYTHON_DEPS}
	>=app-arch/snappy-1.1.1[${MULTILIB_USEDEP}]
	>=sys-libs/zlib-1.2.8-r1[${MULTILIB_USEDEP}]
	>=media-libs/mesa-9.1.6[egl?,${MULTILIB_USEDEP}]
	egl? ( || (
		>=media-libs/mesa-8.0[gles1,gles2]
		<media-libs/mesa-8.0[gles]
	) )
	media-libs/libpng:0=
	sys-process/procps[${MULTILIB_USEDEP}]
	x11-libs/libX11
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
	"${FILESDIR}"/${PN}-9999-fix-libbacktrace-build.patch
)

src_configure() {
	my_configure() {
		mycmakeargs=(
			-DENABLE_EGL="$(usex egl)"
			-DDOC_INSTALL_DIR="/usr/share/doc/${PF}"
		)
		if multilib_is_native_abi ; then
			mycmakeargs+=(
				-DENABLE_CLI="$(usex cli)"
				-DENABLE_GUI="$(usex qt5)"
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

	make_desktop_entry qapitrace QApitrace media-playback-start Development;
}

multilib_src_install() {
	cmake-utils_src_install "${_cmake_args[@]}"

	dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so
	dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so.1
	dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so.1.2
}
