# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils

DESCRIPTION="Extcalc graphical scientific calculator based on QT4"
HOMEPAGE="http://extcalc-linux.sourceforge.net/"
SRC_URI="mirror://sourceforge/extcalc-linux/${P}-1.tar.gz"

KEYWORDS="amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
LANGS="de en"
IUSE="l10n_de l10n_en"

DEPEND="dev-qt/qtgui:4
	virtual/opengl"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}-1

DOCS="${S}/doc/*"
