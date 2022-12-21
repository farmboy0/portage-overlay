# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="A glib wrapper for the OpenVR and the OpenXR APIs."
HOMEPAGE="https://gitlab.freedesktop.org/xrdesktop/gxr"

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
	>=media-libs/gulkan-0.16.0
	media-libs/openxr
	>=x11-libs/gtk+-3.22
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	>=dev-util/meson-0.52.0
	virtual/pkgconfig
"
