# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1
inherit eutils multilib systemd udev user autotools-multilib

DESCRIPTION="PC/SC Architecture smartcard middleware library"
HOMEPAGE="http://pcsclite.alioth.debian.org/"

STUPID_NUM="3991"
MY_P="${PN}-${PV/_/-}"
SRC_URI="http://alioth.debian.org/download.php/file/${STUPID_NUM}/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

# GPL-2 is there for the init script; everything else comes from
# upstream.
LICENSE="BSD ISC MIT GPL-3+ GPL-2"

KEYWORDS="~amd64"
SLOT="0"

# This is called libusb so that it doesn't fool people in thinking that
# it is _required_ for USB support. Otherwise they'll disable udev and
# that's going to be worse.
IUSE="libusb policykit selinux +udev"

REQUIRED_USE="^^ ( udev libusb )"

CDEPEND="libusb? ( virtual/libusb:1[${MULTILIB_USEDEP}] )
	selinux? ( sec-policy/selinux-pcscd )
	udev? ( virtual/udev[${MULTILIB_USEDEP}] )
	policykit? ( >=sys-auth/polkit-0.111[${MULTILIB_USEDEP}] )"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	!<app-crypt/ccid-1.4.1-r1
	!<sys-apps/baselayout-2
	!<sys-apps/openrc-0.11.8"

PATCHES=(
	"${FILESDIR}"/${P}-polkit-pcscd.patch
	"${FILESDIR}"/${P}-nopolkit.patch
)

pkg_setup() {
	enewgroup openct # make sure it exists
	enewgroup pcscd
	enewuser pcscd -1 -1 /run/pcscd pcscd,openct
}

src_configure() {
	local myeconfargs=(
		--disable-maintainer-mode
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
		--enable-usbdropdir="${EPREFIX}/usr/$(get_libdir)/readers/usb"
		--enable-ipcdir=/run/pcscd
		$(use_enable udev libudev)
		$(use_enable libusb)
		$(use_enable policykit polkit)
		"$(systemd_with_unitdir)"
		${myconf}
	)
	autotools-multilib_src_configure
}

DOCS=( AUTHORS DRIVERS HELP README SECURITY ChangeLog )

src_install() {
	autotools-multilib_src_install
	prune_libtool_files

	newinitd "${FILESDIR}"/pcscd-init.7 pcscd

	if use udev; then
		insinto "$(get_udevdir)"/rules.d
		doins "${FILESDIR}"/99-pcscd-hotplug.rules
	fi
}

pkg_postinst() {
	elog "Starting from version 1.6.5, pcsc-lite will start as user nobody in"
	elog "the pcscd group, to avoid running as root."
	elog ""
	elog "This also means you need the newest drivers available so that the"
	elog "devices get the proper owner."
	elog ""
	elog "Furthermore, a conf.d file is no longer installed by default, as"
	elog "the default configuration does not require one. If you need to"
	elog "pass further options to pcscd, create a file and set the"
	elog "EXTRA_OPTS variable."
	elog ""
	if use udev; then
		elog "Hotplug support is provided by udev rules; you only need to tell"
		elog "the init system to hotplug it, by setting this variable in"
		elog "/etc/rc.conf:"
		elog ""
		elog "    rc_hotplug=\"pcscd\""
	fi
}
