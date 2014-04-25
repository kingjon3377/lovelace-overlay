# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EHG_REPO_URI="https://code.google.com/p/inkscape2tikz/"

PYTHON_COMPAT=( python{2_5,2_6,2_7} )
inherit mercurial distutils-r1

DESCRIPTION="SVG to PGF/TikZ converter"
HOMEPAGE="https://code.google.com/p/inkscape2tikz/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

#DEPEND=""
RDEPEND="${DEPEND}
	media-gfx/inkscape"

# FIXME: Run tests
