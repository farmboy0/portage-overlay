# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
EGIT_REPO_URI="https://github.com/coelckers/ZMusic"
CMAKE_ECLASS=cmake

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-r3"
	EXPERIMENTAL="true"
fi

inherit cmake-multilib ${GIT_ECLASS}

DESCRIPTION="GZDoom's music system as a standalone library"
HOMEPAGE="https://forum.zdoom.org/index.php"

if [[ $PV == 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="${EGIT_REPO_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
"
DEPEND="${RDEPEND}"
