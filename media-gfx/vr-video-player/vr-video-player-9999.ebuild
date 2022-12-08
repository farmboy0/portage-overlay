# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="A vr video player playing stereoscopic videos. Also works for games."
HOMEPAGE="https://git.dec05eba.com/vr-video-player"
SRC_URI=""
EGIT_REPO_URI="git://git.dec05eba.com/vr-video-player"

LICENSE="DEC05EBA"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	media-libs/glew:0
	media-libs/glm
	media-libs/libsdl2
	media-libs/openvr
	media-video/mpv
	x11-libs/libXcomposite
	x11-libs/libXfixes
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	virtual/pkgconfig
"

src_compile() {
	./build.sh
}

src_install() {
	mkdir -p "${D}"/usr/bin "${D}"/usr/share/vr-video-player
	cp ./vr-video-player "${D}"/usr/bin
	cp -R ./config/* "${D}"/usr/share/vr-video-player
}
