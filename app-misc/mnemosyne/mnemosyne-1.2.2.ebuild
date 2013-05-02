# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

DESCRIPTION="Sophisticated flash-card tool also used for long-term memory research"
HOMEPAGE="http://www.mnemosyne-proj.org/"
SRC_URI="mirror://sourceforge/${PN}-proj/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="latex"

DEPEND="latex? ( app-text/dvipng )
	dev-python/PyQt
	dev-python/pygame
	dev-python/imaging"
RDEPEND="${DEPEND}"

src_prepare() {
	if ! use latex ; then
		sed -i \
			-e "s/process_latex(latex_command):/process_latex(latex_command):\n    return latex_command/" \
			mnemosyne/core/mnemosyne_core.py || die "sed failed"
	fi
}
