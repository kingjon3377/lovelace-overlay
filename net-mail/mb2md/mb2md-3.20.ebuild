# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Converts one or more Mbox format mailbox files in a directory to Maildir format"
HOMEPAGE="http://batleth.sapienti-sat.org/projects/mb2md/"
SRC_URI="http://batleth.sapienti-sat.org/projects/mb2md/${P}.pl.gz"
LICENSE="public-domain"
KEYWORDS="x86 amd64"
SLOT="0"

DEPEND="dev-perl/TimeDate"
RDEPEND="${DEPEND}"
IUSE=""

S="${WORKDIR}"

src_install() {
	newbin ${P}.pl mb2md
}
