# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Virtual to pull in either the source or the binary package for Eclipse IDE"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

SLOT="4.3"

DEPEND=""
RDEPEND="${DEPEND}
	dev-util/eclipse-sdk-bin:${SLOT}"
