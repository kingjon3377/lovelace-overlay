# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
EHG_REPO_URI="http://hg.einsteinmg.dyndns.org/grml-shlib"

inherit mercurial

DESCRIPTION="Generic shell library used in grml scripts"
HOMEPAGE="http://packages.ubuntu.com/natty/grml-shlib"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-apps/iproute2
	sys-apps/net-tools
	sys-process/procps"
RDEPEND="${DEPEND}"
