# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

ESVN_REPO_URI="svn://svn.icculus.org/smjpeg/trunk/"

inherit autotools multilib-minimal subversion

DESCRIPTION="SDL Motion JPEG Library"
HOMEPAGE="http://www.lokigames.com/development/smjpeg.php3"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=media-libs/libsdl-1.1.7"
DEPEND="${RDEPEND}"

DOCS=( CHANGES README TODO SMJPEG.txt )

src_prepare() {
    rm acinclude.m4
    eapply_user
    eautoreconf
}

multilib_src_configure() {
    ECONF_SOURCE=${S} econf --disable-static
}

multilib_src_install_all() {
    einstalldocs
    find "${ED}" -type f -name "*.la" -delete
}
