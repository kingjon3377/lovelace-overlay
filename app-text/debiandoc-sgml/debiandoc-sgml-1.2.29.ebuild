# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# TODO: Get improvements from version in Sunrise overlay.

EAPI=7

inherit perl-module

DESCRIPTION="Debian SGML documentation tools"
HOMEPAGE="https://packages.debian.org/source/sid/debiandoc-sgml"
#SRC_URI="mirror://debian/pool/main/d/debiandoc-sgml/${PN}_${PV}.tar.gz"
SRC_URI="mirror://debian/pool/main/d/debiandoc-sgml/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="+latex"

DEPEND="dev-perl/HTML-Parser
	virtual/perl-I18N-LangTags
	dev-perl/Roman
	dev-perl/SGMLSpm
	dev-perl/Text-Format
	dev-perl/URI
	app-text/sgml-common
	app-text/openjade"
RDEPEND="${DEPEND}
	latex? ( dev-texlive/texlive-latexextra )"

# Tries to run test from non-existent debian/ directory
RESTRICT=test

src_prepare() {
	default
	sed -i -e 's,^prefix		:= /usr/local$,prefix		:= /usr,' \
		-e 's,^man_dir		:= $(prefix)/man$,man_dir		:= $(DESTDIR)$(prefix)/man,' \
		-e 's,^perl_dir	:= $(share_dir)/perl5$,perl_dir	:= $(DESTDIR)$(prefix)/lib/perl5/site_perl,' \
		Makefile || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install
}
