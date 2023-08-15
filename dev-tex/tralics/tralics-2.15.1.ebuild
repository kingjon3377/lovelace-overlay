# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="LaTeX to XML translator"
HOMEPAGE="https://www-sop.inria.fr/marelle/tralics/"
SRC_URI="ftp://ftp-sop.inria.fr/marelle/${PN}/src/${PN}-src-${PV}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( app-text/texlive-core )" # bibtex

RESTRICT="!test? ( test )"

src_prepare() {
	# The patch series is the git history of the softcover project's fork. We
	# apply it since we want to package softcover.

	# The first patch falls afoul of relative-path-in-patch detection, but
	# consists entirely of file removals, so we just remove them.
	pushd Test > /dev/null || die
	rm -f amsldoc.log amsldoc.xml beauvilams2.log beauvilams2.xml bo.log \
		bo.xml comp_pi.log comp_pi.xml ex_emple2008.log ex_emple2008.xml \
		exemple2003.log exemple2003.xml exemple2005.log exemple2005.xml \
		exemple2006.log exemple2006.xml exemple2007.log exemple2007.xml \
		exemple2008.log exemple2008.xml exemple2009.log exemple2009.xml \
		exemple2011.log exemple2011.xml exempleb.xml exempleb2011.log \
		fptest.log fptest.xml hello.log hello.xml hello1.log hello1.xml \
		hello2.log hello2.xml hello3.log hello3.xml mathmlc.log mathmlc.xml \
		testb.log testb.xml testb0.xml testb1.log testb1.xml testbe.log \
		testbe.xml testclass.log testclass.xml testerr.log testerr.xml \
		testhtml.log testhtml.xml testkeyval.log testkeyval.xml testm1.log \
		testm1a.xml testm1b.xml testm1c.xml testmath.log testmath.xml \
		testpack.log testpack.xml testpackii.log testpackii.xml teststr.log \
		teststr.xml tormath.log tormath.xml tormath1.log tormath1.xml \
		tormath2.log tormath2.xml tormath3.log tormath3.xml torture.log \
		torture.xml tpa.log tpa.xml tpa2.log tpa2.xml tpa2x.xml txerr.log \
		txerr.xml txtc.log txtc.xml txtd.log txtd.xml xii.log xii.xml || die
	popd > /dev/null || die
	# Patch 0003 removes a file that wasn't in the tarball, so we skip it.
	# Patch 0004 patches the .gitignore, not in the tarball.
	# Patch 0005 also patches .gitignore, and also the tralics binary, so we edit the patch to remove those sections.
	# Patch 0007 patches the .gitignore and removes the tralics binary, which wasn't in the tarball, so we remove it.
	# Patch 0008 upgrades the git repository to match the tarball, so we remove it.
	eapply "${FILESDIR}"/*.patch
	sed -i -e 's/^CPPFLAGS/#&/' src/Makefile || die
	sed -i -e "s@tralics \([0-9]\.[0-9][0-9]\.[0-9]\|[0-9]\.[0-9]\), date: [0-9][0-9][0-9][0-9]/[0-9][0-9]/[0-9][0-9]@tralics ${PV}, date: $(date +%Y/%m/%d)@" \
		-e "s@Tralics version [0-9]\.[0-9][0-9]\.[0-9]@Tralics version ${PV}@" Modele/*.xml || die
	sed -i -e "s@<date_prod>2012-5-14</date_prod>@<date_prod>$(date +%Y-%-m-%-d)</date_prod>@" Modele/bo.xml || die
	sed -i -e "s@<Article C='2006/9/21' Foo='world' B='Tralics version [0-9.]*' A='2006'>@<Article C='$(date +Y/%-m/%-d)' Foo='world' B='Tralics version ${PV}' A='2'>@" Modele/hello2.xml || die
	sed -i -e 's@\(epW=5\.opE\.\)\(CuCvLaD\)@\1badpack5a.\2@' Modele/testkeyval.xml || die
	eapply_user
}

src_compile() {
	emake -C src CC=$(tc-getCXX) CCC=$(tc-getCXX) CXX=$(tc-getCXX) \
		CPPFLAGS="${CFLAGS} -DTRALICSDIR=\\\"/usr/share/${PN}\\\" -DCONFDIR=\\\"/usr/share/${PN}\\\""
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
	dodoc README.md README_ORIGINAL
}
