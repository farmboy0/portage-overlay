# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="A 3DUI widget toolkit."
HOMEPAGE="https://gitlab.freedesktop.org/xrdesktop/g3k"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/xrdesktop/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://gitlab.freedesktop.org/xrdesktop/${PN}/-/archive/${PV}/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0/9999"
IUSE=""

DEPEND="
	dev-libs/glib
	dev-libs/json-glib
	>=media-libs/gxr-0.16.0
	media-libs/libcanberra
	media-libs/shaderc
	x11-libs/pango
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	virtual/pkgconfig
"
