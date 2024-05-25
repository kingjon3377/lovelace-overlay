# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Converts one or more Mbox format mailbox files in a directory to Maildir format"
HOMEPAGE="http://batleth.sapienti-sat.org/projects/mb2md/"
SRC_URI="http://batleth.sapienti-sat.org/projects/${PN}/${P}.pl.gz"
S="${WORKDIR}"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="dev-perl/TimeDate"
RDEPEND="${DEPEND}"

src_install() {
	newbin ${P}.pl mb2md
}
