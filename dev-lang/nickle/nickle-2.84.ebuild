# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="desk calculator language"
HOMEPAGE="https://nickle.org"
SRC_URI="https://nickle.org/release/${P}.tar.gz"

LICENSE="BSD-1"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

# TODO: Add tools (something jade?) used in build to BDEPEND
DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README README.name README.release TODO )
