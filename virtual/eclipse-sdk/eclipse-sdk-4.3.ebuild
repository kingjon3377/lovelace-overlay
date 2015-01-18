# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Virtual to pull in either the source or the binary package for Eclipse IDE"
HOMEPAGE="http://www.eclipse.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

SLOT="4.3"

DEPEND=""
RDEPEND="${DEPEND}
	dev-util/eclipse-sdk-bin:${SLOT}"
