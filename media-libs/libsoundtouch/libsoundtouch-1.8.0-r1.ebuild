# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_PRUNE_LIBTOOL_FILES=all
inherit autotools-multilib flag-o-matic

MY_PN=${PN/lib}

DESCRIPTION="Audio processing library for changing tempo, pitch and playback rates."
HOMEPAGE="http://www.surina.net/soundtouch/"
SRC_URI="http://www.surina.net/soundtouch/${P/lib}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="sse2 static-libs"

DEPEND="virtual/pkgconfig"

S=${WORKDIR}/${MY_PN}

PATCHES=( "${FILESDIR}"/${PN}-1.7.0-flags.patch )
DOCS=( )

src_prepare() {
	sed -i "s:^\(pkgdoc_DATA=\)COPYING.TXT :\1:" Makefile.am || die
	sed -i 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:g' configure.ac || die

	autotools-multilib_src_prepare
}

src_configure() {
	local myeconfargs=(
		--enable-shared
		--disable-integer-samples
		--enable-x86-optimizations=$(usex sse2)
		$(use_enable static-libs static)
	)
	autotools-multilib_src_configure
}

src_install() {
	autotools-multilib_src_install \
		pkgdocdir="${EPREFIX}"/usr/share/doc/${PF}/html
}
