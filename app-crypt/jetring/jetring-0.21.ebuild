# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="gpg keyring mantainance using changesets"
HOMEPAGE="http://kitenet.net/~joey/code/jetring/"
SRC_URI="mirror://debian/pool/main/j/${PN}/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-crypt/gnupg"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_install() {
	emake DESTDIR="${D}" install
	doman *.1 *.7
	dodoc README sample.changeset debian/changelog
	docinto example
	dodoc -r example/*
}
