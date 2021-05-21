# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools gnome2

DESCRIPTION="A tool for creating graphical dialogs from shell scripts. Fork of zenity."
HOMEPAGE="https://github.com/v1cont/yad"

SRC_URI="https://github.com/v1cont/yad/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="debug webkit"

RDEPEND="
        >=dev-libs/glib-2.8:2
        x11-libs/gdk-pixbuf:2
        >=x11-libs/gtk+-3:3[X]
        x11-libs/libX11
        x11-libs/pango
        webkit? ( >=net-libs/webkit-gtk-2.8.1:4 )
"
DEPEND="${RDEPEND}
        dev-util/itstool
        >=sys-devel/gettext-0.19.4
        virtual/pkgconfig
"

src_prepare() {
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
        gnome2_src_configure \
                $(usex debug --enable-debug=yes ' ') \
                $(use_enable webkit html) \
                PERL=$(type -P false)
}
