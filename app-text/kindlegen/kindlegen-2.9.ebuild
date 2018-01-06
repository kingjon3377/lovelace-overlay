# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit versionator

DESCRIPTION="Amazon's ebook converter to the Kindle format"
HOMEPAGE="https://www.amazon.com/gp/feature.html?docId=1000765211"
SRC_URI="http://kindlegen.s3.amazonaws.com/${PN}_linux_2.6_i386_v$(replace_all_version_separators '_').tar.gz"

LICENSE="kindlegen Info-ZIP IJG Apache-2.0 BSD MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

strip_bom() {
	sed -i -e '1s/^\xef\xbb\xbf//' "$@"
}

src_prepare() {
	find . -name \*.html -name \*.txt | while read line; do
		strip_bom "${line}"
	done
}

src_install() {
	dobin "${PN}"
	dohtml manual.html
	# TODO: install non-English docs based on $L10N
	newdoc "docs/english/known issues.txt" known_issues.txt
	newdoc docs/english/Readme.txt README
	mv -i "docs/english/Release Notes.html" docs/english/Release_Notes.html
	dohtml docs/english/Release_Notes.html
}
