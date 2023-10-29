# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="copy-on-write utility"
HOMEPAGE="http://www.xmailserver.org/flcow.html"
SRC_URI="http://www.xmailserver.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="${DEPEND}"

src_test() {
	emake -C test # FIXME: Do this in src_compile if USE=test
	cd test
	./flcow-test.sh || ewarn "tests failed, probably a sandbox problem"
}

DOCS=( AUTHORS ChangeLog NEWS README docs/flcow.html )
