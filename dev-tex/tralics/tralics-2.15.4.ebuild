# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs eutils

DESCRIPTION="LaTeX to XML translator"
HOMEPAGE="http://www-sop.inria.fr/marelle/tralics/"
SRC_URI="ftp://ftp-sop.inria.fr/marelle/${PN}/src/${PN}-src-${PV}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( app-text/texlive-core )" # bibtex

# TODO: Investigate the github.com/softcover/tralics fork, possibly adding some of its changes as patches
src_prepare() {
	# Fix tests broken by time-gap between test creation and execution
	sed -i -e "s@\(Translated from latex by tralics \)[0-9.]*\(, date: \)[0-9/]*@\1${PV}\2$(date +%Y/%m/%d)@" \
		-e "s@Tralics version [0-9.]*'@Tralics version ${PV}'@" Modele/*.xml || die
	sed -i -e "s@<date_prod>2012-5-14</date_prod>@<date_prod>$(date +%Y-%-m-%-d)</date_prod>@" Modele/bo.xml || die
	sed -i -e "s@<Article C='2006/9/21' Foo='world' B='Tralics version [0-9.]*' A='2006'>@<Article C='$(date +Y/%-m/%-d)' Foo='world' B='Tralics version ${PV}' A='2'>@" Modele/hello2.xml || die
	sed -i -e 's@\(epW=5\.opE\.\)\(CuCvLaD\)@\1badpack5a.\2@' Modele/testkeyval.xml || die
	default
}

src_compile() {
	emake -C src CC=$(tc-getCXX) CCC=$(tc-getCXX) CXX=$(tc-getCXX) \
		CPPFLAGS="${CPPFLAGS} -DTRALICSDIR=\\\"/usr/share/${PN}\\\" -DCONFDIR=\\\"/usr/share/${PN}\\\""
}

src_test() {
	cd Test
	./alltests || die "Tests failed"
}

src_install() {
	dobin src/${PN}
	# Following Debian, we put all "configuration" files in /usr/share.
	# TODO: move what *should* be to /etc to there, if anything should.
	insinto /usr/share/${PN}
	doins confdir/*
	rm "${D}/usr/share/${PN}/COPYING"
	doman "${FILESDIR}/${PN}.1"
	dodoc README
}
