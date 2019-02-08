# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="meta search and replace tool for both filenames and files"
HOMEPAGE="http://complearn.org"
SRC_URI="http://complearn.org/downloads/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-libs/libpcre"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README )
