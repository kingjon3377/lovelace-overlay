# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eapi7-ver

DESCRIPTION="Amazon's ebook converter to the Kindle format"
HOMEPAGE="https://www.amazon.com/gp/feature.html?docId=1000765211"
SRC_URI="http://kindlegen.s3.amazonaws.com/${PN}_linux_2.6_i386_v$(ver_rs 1- '_').tar.gz"

LICENSE="kindlegen Info-ZIP IJG Apache-2.0 BSD MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="l10n_zh l10n_nl l10n_fr l10n_de l10n_it l10n_ja l10n_es"

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
	for file in docs/*/*\ *;do
		mv -i "${file}" "${file// /_}" || die
	done
	default
}

src_install() {
	dobin "${PN}"
	dodoc manual.html docs/english/known_issues.txt \
		docs/english/Release_Notes.html
	newdoc docs/english/Readme.txt README
	if use l10n_zh;then
		docinto zh
		dodoc docs/chinese/*
	fi
	if use l10n_nl;then
		docinto nl
		dodoc docs/dutch/*
	fi
	if use l10n_fr;then
		docinto fr
		dodoc docs/french/*
	fi
	if use l10n_de;then
		docinto de
		dodoc docs/german/*
	fi
	if use l10n_it;then
		docinto it
		dodoc docs/italian/*
	fi
	if use l10n_ja;then
		docinto ja
		dodoc docs/japanese/*
	fi
	if use l10n_es;then
		docinto es
		dodoc docs/spanish/*
	fi
}
