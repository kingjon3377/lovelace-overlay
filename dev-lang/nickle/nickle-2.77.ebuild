# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="desk calculator language"
HOMEPAGE="http://nickle.org"
SRC_URI="http://nickle.org/release/${P}.tar.gz"

LICENSE="BSD-1"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/tutorial-close-tags-nickle.git-1e29f3df828ec68ca7b4556e9b1bb830c8afbb4b.patch"
)

DOCS=( AUTHORS ChangeLog NEWS README README.name README.release TODO )
