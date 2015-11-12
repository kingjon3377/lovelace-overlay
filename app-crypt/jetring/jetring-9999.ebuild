# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_REPO_URI="git://git.kitenet.net/jetring"

inherit git-2

DESCRIPTION="gpg keyring mantainance using changesets"
HOMEPAGE="http://kitenet.net/~joey/code/jetring/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-crypt/gnupg"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install
	doman *.1
}
