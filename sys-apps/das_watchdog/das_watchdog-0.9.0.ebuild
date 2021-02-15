# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs readme.gentoo-r1 optfeature

RESTRICT="mirror"
DESCRIPTION="watchdog to ensure a realtime process won't hang the machine"
HOMEPAGE="http://www.notam02.no/arkiv/src/"
SRC_URI="http://www.notam02.no/arkiv/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="gnome-base/libgtop:2=
		|| ( x11-base/xorg-x11 x11-apps/xmessage )"
RDEPEND="${DEPEND}"

DOC_CONTENTS="
now add the script to your runlevel
e.g. rc-update add ${PN} default
"

src_prepare() {
	#fix makefile
	sed -i -e 's@gcc@$(CC) $(CFLAGS)@g' -e	's@\@sh.*@@g' \
		-e 's@^[[:blank:]]*which.*@@g'  Makefile
	default
}

src_compile() {
	#CONFIG="-O2 `pkg-config --libs --cflags libgtop-2.0` -Wall -lpthread -DWHICH_WISH=\"`which xmessage`\" -DVERSION=\"$(PV)\""
	#$(tc-getCC) ${CFLAGS} das_watchdog.c -o  ${PN} ${CONFIG} || die "compile failed"
	emake VERSION="${PV}"
}

src_install() {
	dosbin ${PN}
	dobin test_rt
	dodoc README
	newinitd "${FILESDIR}/das_watchdog-init.d" ${PN}
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
	optfeature "a realtime kernel" sys-kernel/rt-sources
}
