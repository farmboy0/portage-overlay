# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxkbfile/libxkbfile-1.0.8.ebuild,v 1.10 2013/02/25 08:29:30 zmedico Exp $

EAPI=5
XORG_MULTILIB=yes

inherit xorg-2

DESCRIPTION="X.Org xkbfile library"

KEYWORDS="~amd64"
IUSE=""

RDEPEND="x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-proto/kbproto[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

pkg_setup() {
	xorg-2_pkg_setup
}