# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils bash-completion-r1

DESCRIPTION="Dynamic Kernel Module Support"
SRC_URI="https://github.com/dell/dkms/archive/v${PV}.tar.gz -> ${P}.tar.gz"
HOMEPAGE="https://github.com/dell/dkms"
LICENSE="GPL-2"
DEPEND=""
RDEPEND="app-arch/rpm"
KEYWORDS="*"
SLOT="0"

src_compile() {
	return
}

src_install() {
	make DESTDIR="$D" install
}
