# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Tool to return the body of an email message"
HOMEPAGE="https://www.toastfreeware.priv.at/"
SRC_URI="https://www.toastfreeware.priv.at/tarballs/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/mimetic"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README )
