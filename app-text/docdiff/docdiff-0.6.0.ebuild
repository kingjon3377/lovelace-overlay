# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby30 ruby31 ruby32"

inherit ruby-ng

DESCRIPTION="Compares two files word by word / char by char"
HOMEPAGE="http://www.kt.rim.or.jp/~hisashim/docdiff/"
SRC_URI="https://github.com/hisashim/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${DEPEND}"

each_ruby_prepare() {
	sed -i -e "s@^RUBY = ruby@RUBY = ${RUBY}@" Makefile || die
}

all_ruby_compile() {
	emake readme.en.html index.en.html
}

each_ruby_test() {
	emake test
}

each_ruby_install() {
	pushd lib > /dev/null || die
	doruby -r *
	popd > /dev/null || die
}

all_ruby_install() {
	emake install DESTDIR="${ED}" PREFIX="/usr"
	mv "${ED}/usr/share/doc/${PN}" "${ED}/usr/share/doc/${PF}" || die
}
