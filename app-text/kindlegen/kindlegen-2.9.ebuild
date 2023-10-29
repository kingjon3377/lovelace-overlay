# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Amazon's ebook converter to the Kindle format"
HOMEPAGE="https://www.amazon.com/gp/feature.html?docId=1000765211"
SRC_URI="http://kindlegen.s3.amazonaws.com/${PN}_linux_2.6_i386_v$(ver_rs 1- '_').tar.gz"

LICENSE="kindlegen Info-ZIP IJG Apache-2.0 BSD MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="l10n_zh l10n_nl l10n_fr l10n_de l10n_it l10n_ja l10n_es"

RDEPEND="${DEPEND}"

S="${WORKDIR}"

strip_bom() {
	sed -i -e '1s/^\xef\xbb\xbf//' "$@"
}

src_prepare() {
	find . \( -name \*.html -o -name \*.txt \) -print0 | while read -r -d $'\0' line; do
		strip_bom "${line}"
	done
	for file in docs/*/*\ *;do
		mv -i "${file}" "${file// /_}" || die
	done
	default
}

langdoc() {
	if use "l10n_${1}";then
		docinto "${1}"
		dodoc docs/"${2}"/*
	fi
}

src_install() {
	dobin "${PN}"
	dodoc manual.html docs/english/known_issues.txt \
		docs/english/Release_Notes.html
	newdoc docs/english/Readme.txt README
	langdoc zh chinese
	langdoc nl dutch
	langdoc fr french
	langdoc de german
	langdoc it italian
	langdoc ja japanese
	langdoc es spanish
}
