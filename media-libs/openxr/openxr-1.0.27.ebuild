# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MY_PN=OpenXR-SDK-Source
EGIT_REPO_URI="https://github.com/KhronosGroup/${MY_PN}.git"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-r3"
	EXPERIMENTAL="true"
fi

inherit cmake ${GIT_ECLASS}

DESCRIPTION="Sources for OpenXR loader, basic API layers, and example code."
HOMEPAGE="https://github.com/KhronosGroup/OpenXR-SDK-Source"

if [[ ${PV} == 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="https://github.com/KhronosGroup/${MY_PN}/archive/refs/tags/release-${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${MY_PN}-release-${PV}"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="layers +wayland +X"

BDEPEND=">=dev-util/cmake-3.10.2"
DEPEND="
	media-libs/vulkan-loader
	media-libs/mesa
	dev-libs/jsoncpp:=
	wayland? (
		dev-libs/wayland
		dev-libs/wayland-protocols
		dev-util/wayland-scanner
	)
	X? (
		x11-libs/libxcb
		x11-libs/xcb-util-keysyms
		x11-libs/libXrandr
		x11-libs/libXxf86vm
	)
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_WITH_SYSTEM_JSONCPP=ON
		-DBUILD_WITH_XLIB_HEADERS=$(usex X)
		-DBUILD_WITH_XCB_HEADERS=$(usex X)
		-DBUILD_WITH_WAYLAND_HEADERS=$(usex wayland)
		-DBUILD_API_LAYERS=$(usex layers)
	)

	cmake_src_configure
}
