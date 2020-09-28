# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Analyze system logs to find problems"
HOMEPAGE="http://frakir.org/~morty/lue/log_analysis.html"
SRC_URI="http://frakir.org/~morty/lue/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

# TODO: What's needed in BDEPEND?
DEPEND="dev-lang/perl
	dev-lang/tk:="
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/separate_rules.patch"
	"${FILESDIR}/${P}-pod2man.patch"
)

DOCS=( NEWS README TODO README.long )
