# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib toolchain-funcs autotools

DESCRIPTION="fast and scalable online machine learning algorithm"
HOMEPAGE="http://hunch.net/~vw/"
SRC_URI="https://github.com/JohnLangford/vowpal_wabbit/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND="dev-libs/boost
	sys-libs/zlib"
DEPEND="${RDEPEND}
	sys-apps/help2man"

src_prepare() {
	#sed -i -e 's:/usr/local/bin:$(DESTDIR)/usr/bin:' Makefile cluster/Makefile \
		#|| die "sed failed"
	default
	tc-export CXX
	eautoreconf
}

src_compile() {
	default
	help2man --no-info --name="Vowpal Wabbit -- fast online learning tool" \
		vowpalwabbit/vw > vowpalwabbit/vw.1 || die
}

src_test() {
	emake test
}

src_install() {
	default
	find "${D}" -name '*.la' -exec rm -f {} +
	find "${D}" -name library_example -delete
	doman vowpalwabbit/vw.1
}
