# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="git://github.com/chipx86/gtkparasite"

inherit git-r3 autotools eutils

DESCRIPTION="GTK+ debugging and development tool"
HOMEPAGE="http://chipx86.github.com/gtkparasite/"

LICENSE="BSD-1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	# bootstrap build system
	eautoreconf
	mkdir debian
	epatch "${FILESDIR}/gtkparasite_0+git20090907-1.diff"
	[[ -d ${P} ]] || einfo "patch worked like we wanted it to"
	[[ -d ${P} ]] && mv -i "${P}"/debian/* debian && rmdir --parents ${P}/debian || die "fixing bad patching job failed"
	default_src_prepare
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc debian/README.Debian
}
