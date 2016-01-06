# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_REPO_URI="git://people.freedesktop.org/~airlied/radeontool"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-r3"
fi

inherit autotools-utils ${GIT_ECLASS}

DESCRIPTION="Manage the backlight, external video output and registers of ATI Radeon graphics cards"

HOMEPAGE="http://people.freedesktop.org/~airlied/radeontool/"

if [[ $PV == 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="http://people.freedesktop.org/~airlied/${PN}/${P}.tar.bz2"
fi

LICENSE="ZLIB"
SLOT="0"
KEYWORDS=""

IUSE=""

RDEPEND=">=x11-libs/libpciaccess-0.12.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

AUTOTOOLS_AUTORECONF=1
