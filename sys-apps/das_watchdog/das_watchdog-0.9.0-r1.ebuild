# Copyright 1999-2023 Gentoo Authors
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

DEPEND="gnome-base/libgtop:2=
		x11-apps/xmessage
		dev-libs/glib:2"
RDEPEND="${DEPEND}"

DOC_CONTENTS="
now add the script to your runlevel
e.g. rc-update add ${PN} default
"

PATCHES=(
	"${FILESDIR}/01-rc.patch"
	"${FILESDIR}/02-makefile.patch"
	"${FILESDIR}/03-hardening.patch"
	"${FILESDIR}/04-Fix-memory-overflow-if-the-name-of-an-environment-is.patch"
	"${FILESDIR}/05-Fixed-memory-leak-in-bd20bb02e75e2c0483832b52f257725.patch"
	"${FILESDIR}/06-Remove-duplicate-check-for-temp-i-0.patch"
	"${FILESDIR}/07-The-result-of-fgetc-is-an-int-not-a-char.patch"
	"${FILESDIR}/08-fix-memory-leak-on-realloc.patch"
)

src_prepare() {
	#fix makefile
	default
	sed -i -e 's@^[[:blank:]]*which.*@@g'  Makefile
	tc-export CC
}

src_compile() {
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
