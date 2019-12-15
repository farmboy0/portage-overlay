# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="DirectDraw Surface (DDS) format plugin for Gimp 2"
HOMEPAGE="https://code.google.com/archive/p/gimp-dds/"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/gimp-dds/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-gfx/gimp-2.8"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -e 's:CFLAGS=.*\$(:CFLAGS+=\$(:' \
	    -e 's:LDFLAGS=:LDFLAGS+=:' \
		-i Makefile || die

	# Fixing incorrect $(LD) usage
	# http://code.google.com/p/gimp-normalmap/issues/detail?id=1
	sed -e 's:\t$(LD) :\t$(CC) :' \
		-i Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	exeinto "$(pkg-config --variable=gimplibdir gimp-2.0)/plug-ins"
	doexe dds || die "Installation failed"

	# No need to install the gimp-dds.odt or the images, as they have the same
	# content as the gimp-dds.pdf
	dodoc README TODO doc/gimp-dds.pdf || die
}
