# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1

DESCRIPTION="Program to roll dices specified in a simple and intuitive way"
HOMEPAGE="https://matteocorti.github.io/roll/"
SRC_URI="https://github.com/matteocorti/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RESTRICT="!test? ( test )"

src_configure() {
	default --with-bash-completion-dir="$(get_bashcompdir)"
}

src_install() {
	default
	dobashcomp bash_completion/${PN}
}
