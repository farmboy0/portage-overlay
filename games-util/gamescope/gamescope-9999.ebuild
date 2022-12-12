# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..10} )

MYMESONARGS="--wrap-mode nofallback --force-fallback-for vkroots"
inherit meson

DESCRIPTION="Micro-compositor formerly known as steamcompgr"
HOMEPAGE="https://github.com/Plagman/gamescope"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/Plagman/gamescope.git"
	EGIT_SUBMODULES=( subprojects/libliftoff )
	inherit git-r3
else
	SRC_URI="https://github.com/Plagman/gamescope/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE="pipewire"

RDEPEND="
	dev-libs/libliftoff
	>=gui-libs/wlroots-0.15.0[X]
	media-libs/libsdl2
	pipewire? ( media-video/pipewire )
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libdrm
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrender
	x11-libs/libXres
	x11-libs/libXtst
	x11-libs/libXxf86vm
"

DEPEND="
	${RDEPEND}
	dev-libs/stb
"

BDEPEND="
	dev-libs/wayland-protocols
	dev-util/glslang
	dev-util/vulkan-headers
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/${PN}-install.patch"
)
