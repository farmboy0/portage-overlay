# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

DESCRIPTION="xrdesktop effect for KWin."
HOMEPAGE="https://gitlab.freedesktop.org/xrdesktop/kwin-effect-xrdesktop"

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
REQUIRED_USE=""

DEPEND="
	>=media-libs/g3k-0.16.0
	media-libs/graphene
	>=media-libs/xrdesktop-0.16.0
	>=x11-libs/libinputsynth-0.16.0
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	virtual/pkgconfig
"
