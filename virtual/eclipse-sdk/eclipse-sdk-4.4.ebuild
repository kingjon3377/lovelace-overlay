# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Virtual to pull in either the source or the binary package for Eclipse IDE"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

SLOT="4.4"

DEPEND=""
RDEPEND="${DEPEND}
	dev-util/eclipse-sdk-bin:${SLOT}"
