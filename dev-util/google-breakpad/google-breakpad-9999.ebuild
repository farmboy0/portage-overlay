# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
inherit git-r3 autotools flag-o-matic

DESCRIPTION="An open-source multi-platform crash reporting system"
HOMEPAGE="http://code.google.com/p/google-breakpad/"
EGIT_REPO_URI="https://chromium.googlesource.com/breakpad/breakpad"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""

src_unpack() {
	git-r3_src_unpack
	git-r3_fetch https://chromium.googlesource.com/linux-syscall-support
	git-r3_checkout https://chromium.googlesource.com/linux-syscall-support "${S}"/src/third_party/lss
}

src_prepare() {
	default

	# Fix docdir
	sed '/^docdir/s@$(PACKAGE)-$(VERSION)@$(PF)@' -i Makefile.am || die

	eautoreconf
}

src_compile() {
	append-flags -fPIC
	default
}

src_install() {
	default

	# Install headers that some programs require to build.
	cd "${S}"

	insinto /usr/include/breakpad
	doins src/client/linux/handler/exception_handler.h

	insinto /usr/include/breakpad/common
	doins src/google_breakpad/common/*.h

	insinto /usr/include/breakpad/client/linux/minidump_writer
	doins src/client/linux/minidump_writer/*.h

	insinto /usr/include/breakpad/client/linux/crash_generation
	doins src/client/linux/crash_generation/*.h

	insinto /usr/include/breakpad/client/linux/dump_writer_common
	doins src/client/linux/dump_writer_common/*.h
}
