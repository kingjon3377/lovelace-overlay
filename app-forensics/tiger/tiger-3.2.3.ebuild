# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Report system security vulnerabilities"
HOMEPAGE="http://www.nongnu.org/tiger/"
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's:^>:test -f:' util/genmsgidx || die
}

src_configure() {
	econf --with-tigerhome=/usr/share/tiger --with-tigerconfig=/etc/tiger \
		--with-tigerwork=/var/run/tiger --with-tigerlog=/var/log/tiger \
		--with-tigerbin=/usr/sbin
}

src_compile() {
	emake "CC=$(tc-getCC)" -j1
}

src_install() {
	dodir /usr/share/man/man8
	dodir /etc/tiger
	dodir /usr/sbin
	emake DESTDIR="${D}" install
}

pkg_postinst() {
	ewarn "Again, this needs a great deal of work to get *working* under"
	ewarn "Gentoo, and we should look closely at the Debian init scripts."
}
