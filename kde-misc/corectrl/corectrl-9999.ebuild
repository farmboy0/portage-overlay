# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

DESCRIPTION="Core control application."
HOMEPAGE="https://gitlab.com/corectrl/corectrl"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://gitlab.com/${PN}/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://gitlab.com/${PN}/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0/9999"
IUSE="+pcinames"
REQUIRED_USE=""

DEPEND="
	dev-qt/qtbase:6[dbus,network,widgets]
	dev-qt/qtcharts:6[qml]
	dev-qt/qtdeclarative:6
	dev-qt/qtsvg:6
	dev-qt/qttools:6[linguist,qml]
	sys-auth/polkit
	dev-libs/quazip[qt6]
	dev-libs/botan:2
	dev-libs/pugixml
	>=dev-libs/spdlog-1.4.0
"
RDEPEND="
	${DEPEND}
	pcinames? ( sys-apps/hwdata )
"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
"

PATCHES=(
)

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=OFF
		-WITH_DEBUG_INFO=ON
	)
	cmake_src_configure
}
