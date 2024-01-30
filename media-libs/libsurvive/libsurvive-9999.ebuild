# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/cntools/libsurvive"
CMAKE_ECLASS=cmake

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-r3"
	EXPERIMENTAL="true"
fi

inherit cmake ${GIT_ECLASS}

DESCRIPTION="Open Source Lighthouse Tracking System"
HOMEPAGE="https://github.com/cntools/libsurvive"

if [[ ${PV} == 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="https://github.com/cntools/libsurvive/releases/download/v${PV}/libsurvive-v${PV}-4-source.zip -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

BDEPEND=">=dev-build/cmake-3.12.0"
DEPEND="
	dev-cpp/eigen
	dev-libs/libusb
	media-libs/openvr
	net-libs/libpcap
	sys-libs/zlib
"

PATCHES=(
    "${FILESDIR}/${PN}-install-libdir.patch"
)

src_configure() {
	local mycmakeargs=(
		-USE_CPU_TUNE=ON
	)

	cmake_src_configure
}
