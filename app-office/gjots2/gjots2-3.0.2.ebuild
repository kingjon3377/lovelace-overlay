# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_{6,7} ) # TODO: does it support python3 now?

inherit multilib distutils-r1 gnome.org

DESCRIPTION="A graphical (GNOME 2) jotter tool"
HOMEPAGE="http://bhepple.freeshell.org/gjots/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="l10n_en l10n_fr l10n_no l10n_nb l10n_ru l10n_it l10n_cs"

DEPEND="dev-python/pygobject:3[${PYTHON_USEDEP}]
	x11-libs/gtksourceview:3.0"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "s@,'bin/gjots2xml','bin/xml2gjots'@@" setup.py || die
	default
}

src_install() {
	distutils-r1_src_install
}
