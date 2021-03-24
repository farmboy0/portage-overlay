# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
EGIT_REPO_URI="https://github.com/FNA-XNA/FAudio"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-r3"
	EXPERIMENTAL="true"
fi

inherit cmake-multilib ${GIT_ECLASS}

DESCRIPTION="XAudio reimplementation including XAudio2, X3DAudio, XAPO, and XACT3."
HOMEPAGE="https://github.com/FNA-XNA/FAudio"

if [[ $PV == 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="${EGIT_REPO_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ffmpeg utils xnasong"

RDEPEND="
	media-libs/libsdl2
	ffmpeg? (
		media-video/ffmpeg
	)
"
DEPEND="${RDEPEND}"

PATCHES=()

src_configure() {
	my_configure() {
		mycmakeargs=(
			-DFFMPEG="$(usex ffmpeg)"
			-DBUILD_UTILS="$(usex utils)"
			-DXNASONG="$(usex xnasong)"
		)
		cmake-utils_src_configure
	}
	multilib_parallel_foreach_abi my_configure
}
