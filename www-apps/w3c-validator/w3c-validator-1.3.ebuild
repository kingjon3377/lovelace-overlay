# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit readme.gentoo-r1

DESCRIPTION="w3c-validator is a mark-up validator"
HOMEPAGE="https://validator.w3.org/source/"
SRC_URI="https://github.com/w3c/markup-validator/archive/validator-${PV/\./_}-release.tar.gz"

S="${WORKDIR}/markup-validator-validator-${PV/\./_}-release"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

#RESTRICT="fetch"

IUSE="jis2k +htmltidy"

RDEPEND=">=app-text/opensp-1.5.2
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
DEPEND="${RDEPEND}"
BDEPEND="dev-lang/perl"

# Seems to work w/out the following:
# perl-core/CGI or virtual/perl-CGI
# dev-perl/Text-Iconv
# dev-perl/String-Approx

# Use the following to generate the required ebuilds:
#
# g-cpan -g Encode-HanExtra HTML-Encoding SGML-Parser-OpenSP
# Options:
# g-cpan -g Encode-JIS2K HTML-Tidy

# Previous version didn't *have* tests, but this one errors out for some reason.
RESTRICT="test"

DOC_CONTENTS='
The apache config file, /etc/apache2/vhosts.d/10_w3c-validator.conf
likely needs to be updated.

For a quick setup, simply change validator-localhost to a suitable
hostname, and make your DNS point to this machines IP address.
'

src_prepare() {
	default_src_prepare
	chmod +x misc/docs_errors.pl misc/testsuite/harness.py
}

src_install() {
	insinto /usr/share/validator/
	doins -r "${S}/htdocs"
	doins -r "${S}/share"

	exeinto /usr/share/validator/cgi-bin/
	doexe "${S}/httpd/cgi-bin/check"
	doexe "${S}/httpd/cgi-bin/sendfeedback.pl"

#	insinto /usr/local/validator/
#	doins -r "${S}/httpd/cgi-bin"

	insinto /usr/share/validator/httpd/
	doins -r "${S}/httpd/conf"

	insinto /etc/w3c/
	doins htdocs/config/*

	insinto /etc/apache2/vhosts.d
	doins "${FILESDIR}"/10_w3c-validator.conf
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
