# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Program to roll dices specified in a simple and intuitive way"
HOMEPAGE="https://matteocorti.github.io/roll/"
SRC_URI="https://github.com/matteocorti/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
IUSE="test"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="!test? ( test )"
