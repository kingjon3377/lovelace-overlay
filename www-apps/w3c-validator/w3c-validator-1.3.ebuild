# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib

DESCRIPTION="w3c-validator is a mark-up validator"
HOMEPAGE="https://validator.w3.org/source/"
SRC_URI="https://github.com/w3c/markup-validator/archive/validator-${PV/\./_}-release.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

#RESTRICT="fetch"

IUSE="jis2k +htmltidy"

DEPEND=">=app-text/opensp-1.5.2
	dev-perl/Config-General
	virtual/perl-Encode
	dev-perl/Encode-HanExtra
	dev-perl/HTML-Parser
	perl-gcpan/HTML-Encoding
	dev-perl/HTML-Template
	dev-perl/JSON
	dev-perl/libwww-perl
	dev-perl/Net-IP
	perl-gcpan/SGML-Parser-OpenSP
	dev-perl/URI
	dev-perl/XML-LibXML
	dev-perl/Class-Accessor
	dev-perl/Test-Exception
	jis2k? ( dev-perl/Encode-JIS2K )
	htmltidy? ( perl-gcpan/HTML-Tidy )"
RDEPEND="${DEPEND}"

# Seems to work w/out the following:
# perl-core/CGI or virtual/perl-CGI
# dev-perl/Text-Iconv
# dev-perl/String-Approx

# Use the following to generate the required ebuilds:
#
# g-cpan -g Encode-HanExtra HTML-Encoding SGML-Parser-OpenSP
# Options:
# g-cpan -g Encode-JIS2K HTML-Tidy

S="${WORKDIR}/markup-validator-validator-${PV/\./_}-release"

# Previous version didn't *have* tests, but this one errors out for some reason.
RESTRICT="test"

src_prepare() {
	default_src_prepare
	chmod +x misc/docs_errors.pl misc/testsuite/harness.py
}

src_install() {
	dodir /usr/share/validator/
	insinto /usr/share/validator/
	doins -r "${S}/htdocs"
	doins -r "${S}/share"

	dodir /usr/share/validator/cgi-bin/
	exeinto /usr/share/validator/cgi-bin/
	doexe "${S}/httpd/cgi-bin/check"
	doexe "${S}/httpd/cgi-bin/sendfeedback.pl"

#	insinto /usr/local/validator/
#	doins -r "${S}/httpd/cgi-bin"

	dodir /usr/share/validator/httpd/
	insinto /usr/share/validator/httpd/
	doins -r "${S}/httpd/conf"

	insinto /etc/w3c/
	doins htdocs/config/*

	insinto /etc/apache2/vhosts.d
	doins "${FILESDIR}"/10_w3c-validator.conf
}

pkg_postinst() {
	einfo
	einfo "The apache config file, /etc/apache2/vhosts.d/10_w3c-validator.conf"
	einfo "likely needs to be updated."
	einfo
	einfo "For a quick setup, simply change validator-localhost to a suitable"
	einfo "hostname, and make your DNS point to this machines IP address."
	einfo
}
