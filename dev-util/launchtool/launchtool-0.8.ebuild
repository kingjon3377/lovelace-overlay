# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Runs a user-supplied command and can supervise its execution in many ways"
HOMEPAGE="http://people.debian.org/~enrico/launchtool.html"
SRC_URI="mirror://debian/pool/main/l/${PN}/${PN}_${PV}.orig.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE=""

RDEPEND="dev-libs/popt"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README )
