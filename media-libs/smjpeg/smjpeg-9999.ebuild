# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

ESVN_REPO_URI="svn://svn.icculus.org/smjpeg/trunk/"

inherit subversion autotools-multilib

DESCRIPTION="SDL Motion JPEG Library"
HOMEPAGE="http://www.lokigames.com/development/smjpeg.php3"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=media-libs/libsdl-1.1.7"
DEPEND="${RDEPEND}"

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_PRUNE_LIBTOOL_FILES=all

DOCS=( CHANGES README TODO SMJPEG.txt )

src_prepare() {
    rm acinclude.m4
    autotools-multilib_src_prepare
}
