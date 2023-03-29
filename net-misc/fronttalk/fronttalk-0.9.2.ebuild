# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

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
	sed -i -e 's,$SYSLIST=.*,$SYSLIST= "http://www.unixpapa.com/syslist";,' \
		-e "s,\$HELPDIR=.*,\$HELPDIR=\"/usr/$(get_libdir)/fronttalk/help\";," \
		-e 's,$DEFAULT_EDITOR=.*,$DEFAULT_EDITOR="/usr/bin/gate";,' \
		-e 's,\($PATH_STTY= "stty"\) ,\1; ,' lib/config.pl \
		|| die "fixing config failed"
	sed -i -e 's@\$\*@*$@' lib/cmd.pl || die "fixing spurious Perl compilation failure failed"
	sed -i -e "s:\"/home/\(janc\|jan\)/src/backtalk/fronttalk/lib\";:\"/usr/$(get_libdir)/fronttalk\":;" \
		-e 's:^use lib[^;]*$:&;:' ft README-fronttalk || die "fixing lib location failed"
	default
}

src_install() {
	dodir /usr/$(get_libdir)/fronttalk/help
	insinto /usr/$(get_libdir)/fronttalk
	doins lib/*
	doins -r help
	dobin ft
	newdoc README-fronttalk README
	ewarn "This just installs the client program; I'd like to make ebuilds for the"
	ewarn "server-side stuff and the rest of Backtalk."
	# TODO: Make such ebuilds
}
