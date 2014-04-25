# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

MY_P1E="RealTimeBattle-${PV}-Ext"
MY_P1S="RealTimeBattle-${PV}-Std"

DESCRIPTION="A programming game in which robots controlled by programs fight each other."
HOMEPAGE="http://realtimebattle.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P1E}.tar.gz "

LICENSE="GPL-2"
KEYWORDS="x86 amd64"
IUSE="perl nls java debug +doc"
SLOT=0

DEPEND=">=x11-libs/gtk+-2.0.3
		perl? ( dev-lang/perl )
		nls? ( sys-devel/gettext )
		java? ( virtual/jre )"
RDEPEND="${DEPEND}"

src_prepare() {
	MY_P="${MY_P1E}"
	#S="${WORKDIR}/${MY_P}" it does not run :(
	cd "${WORKDIR}" &&
		mv ${MY_P} ${P} || die "renaming directory failed"
	epatch "${FILESDIR}/realtimebattle_1.0.8-10.diff"
}

src_configure() {
	econf $(use_enable debug) $(use nls || echo "--disable-nls")
}

src_install(){
	# TODO: fix the makefile to make all this unnecessary
	dodir "${GAMES_DATADIR}" "${GAMES_BINDIR}"
	dosym "../${GAMES_BINDIR#/usr/}" /usr/bin
	dosym "../../${GAMES_DATADIR#/usr/}/RealTimeBattle" /usr/games/RealTimeBattle
	dodir /usr/share/doc/${PF}
	dosym ../../../share/doc/${PF} \
		"${GAMES_DATADIR}/RealTimeBattle/Documentation"
	emake DESTDIR="${D}" install
	rm -f "${D}/usr/bin"
	rm -f "${D}/${GAMES_DATADIR}/RealTimeBattle/Documentation"
	use doc || rm -Rf "${D}/usr/share/doc/${PF}"
	rm -f "${D}/usr/games/RealTimeBattle"
	rm "${D}//usr/share/locale/locale.alias"
}
