# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Tool for parsing flat and CSV files and converting them to different formats"
HOMEPAGE="https://ff-extractor.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/ffe-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${DEPEND}"

S="${WORKDIR}/ffe-${PV}"

DOCS=( AUTHORS ChangeLog NEWS README )
