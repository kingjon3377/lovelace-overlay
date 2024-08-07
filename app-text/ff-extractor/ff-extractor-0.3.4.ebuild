# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Tool for parsing flat and CSV files and converting them to different formats"
HOMEPAGE="https://ff-extractor.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/${PN}/${PN}/${PV}/ffe-${PV}.tar.gz"

S="${WORKDIR}/ffe-${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README )
