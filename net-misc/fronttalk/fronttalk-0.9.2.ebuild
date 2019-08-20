# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib

DESCRIPTION="Client for Backtalk BBS"
HOMEPAGE="http://www.unixpapa.com/backtalk/fronttalk/"
SRC_URI="http://www.unixpapa.com/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="dev-perl/libwww-perl
	app-editors/gate
	|| ( dev-perl/Term-ReadLine-Perl dev-perl/Term-ReadLine-Gnu )
	|| ( dev-perl/Crypt-SSLeay dev-perl/IO-Socket-SSL )"
DEPEND=""

src_prepare() {
	sed -i -e 's,$SYSLIST=.*,$SYSLIST= "http://www.unixpapa.com/syslist",' \
		-e "s,\$HELPDIR=.*,\$HELPDIR=/usr/$(get_libdir)/fronttalk/help," \
		-e 's,$DEFAULT_EDITOR=.*,$DEFAULT_EDITOR=/usr/bin/gate,' lib/config.pl \
		|| die "fixing config failed"
	sed -i -e "s:use lib \"/home/janc/src/backtalk/fronttalk/lib\";:use lib \"/usr/$(get_libdir)/fronttalk\":;" \
		ft || die "fixing lib location failed"
}

src_install() {
	dodir /usr/$(get_libdir)/fronttalk/help
	insinto /usr/$(get_libdir)/fronttalk
	doins lib/*
	doins -r help
	dobin ft
	newdoc README-fronttalk README
	ewarn "This just installs the client program; I'd like to make ebuilds for the server-side stuff and the rest of Backtalk."
	# TODO: Make such ebuilds
}
