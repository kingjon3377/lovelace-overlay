# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="An HTML syntax checker. Installs both a command and a cgi script"
HOMEPAGE="http://www.htmlhelp.com/tools/validator/source.html"

SRC_URI="http://ftp.debian.org/debian/pool/main/w/wdg-html-validator/wdg-html-validator_${PV}.orig.tar.gz
	http://www.htmlhelp.com/tools/validator/src/wdg-sgml-lib-1.1.4.tar.gz"

LICENSE="Artistic"

SLOT="0"
KEYWORDS="~x86 amd64"

IUSE="https"

DEPEND="app-text/opensp
	perl-core/CGI
	dev-perl/libwww-perl
	dev-perl/URI
	dev-perl/Unicode-String
	dev-perl/Unicode-Map8
	https? ( dev-perl/Crypt-SSLeay )"
RDEPEND="${DEPEND}"

# assumes a web server on localhost with a cgi-bin
# jconv needed for Japanese pages ftp://ftp.oreilly.com/pub/examples/nutshell/cjkv/src/jconv.c

src_prepare() {
	sed -i -e "s:/usr/local/share/wdg/sgml-lib:/usr/share/wdg/sgml-lib:" \
		-e "s:/usr/local/bin/lq-nsgmls:/usr/bin/onsgmls:" validate

	sed -i -e "s:use CGI:use lib '/usr/share/wdg/lib';\nuse CGI:" \
		-e "s:/usr/local/bin/lq-nsgmls -E40:/usr/bin/onsgmls -E100:" \
		-e "s:/usr/local/bin:/usr/bin:" \
		-e "s:/usr/local/www/data/tools/validator/lib:/usr/share/wdg/sgml-lib:" \
		-e "s:/usr/local/www/cgi-bin/templates/validator:/usr/share/wdg/www/templates:" cgi-bin/validate.cgi
}

src_install() {
	insinto /usr/share/wdg/lib
	doins lib/SpiderUA.pm
	doins lib/HTMLLinkExtractor.pm

	dobin validate
	newbin lib/cjkvconv.pl cjkvconv

	exeinto /var/www/localhost/cgi-bin
	doexe cgi-bin/validate.cgi

	insinto /usr/share
	doins -r ../wdg

	insinto /usr/share/wdg/www
	doins -r html/*
}

pkg_postinst() {
	einfo "Before using validate.cgi you must: g-cpan.pl I18N::Charset"
}
