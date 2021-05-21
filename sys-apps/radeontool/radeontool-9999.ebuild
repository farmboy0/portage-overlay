# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="git://people.freedesktop.org/~airlied/radeontool"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-r3"
fi

inherit autotools ${GIT_ECLASS}

DESCRIPTION="Utility to get/set registers and controlling backlight on radeon based GPUs"
HOMEPAGE="https://cgit.freedesktop.org/~airlied/radeontool/"

if [[ $PV == 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="http://people.freedesktop.org/~airlied/${PN}/${P}.tar.bz2"
fi

LICENSE="ZLIB"
SLOT="0"
KEYWORDS=""

IUSE=""

RDEPEND="x11-libs/libpciaccess"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	default
        eautoreconf
}
