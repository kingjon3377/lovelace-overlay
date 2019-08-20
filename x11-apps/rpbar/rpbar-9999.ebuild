# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 toolchain-funcs

DESCRIPTION="Taskbar for ratpoison window manager"
HOMEPAGE="https://github.com/dimatura/rpbar"
SRC_URI=""
EGIT_REPO_URI="https://github.com/dimatura/rpbar.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}
	x11-wm/ratpoison"

src_prepare() {
	sed -i \
		-e "s@^CXX=.*@CXX=$(tc-getCXX)@" \
		-e "s@^CXXFLAGS=.*@CXXFLAGS=${CXXFLAGS}@" \
		-e 's@^LIBS=.*@& $(LDFLAGS)@' \
		Makefile || die
	default
}

src_install() {
	dobin ${PN} ${PN}send
	dodoc README.md
	# TODO: Convert this to a file in ${FILESDIR}
	cat > "${T}/ratpoisonrc.sample" <<-EOF
# tell ratpoison to ignore rpbar
unmanage rpbar
# leave space for bars
set padding 0 14 0 14
# start rpbar
exec rpbar
# hooks
addhook switchwin exec rpbarsend
addhook switchframe exec rpbarsend
addhook switchgroup exec rpbarsend
addhook deletewindow exec rpbarsend
# All RP versions in the Portage tree have these hooks.
# Recommended!
addhook titlechanged exec rpbarsend
addhook newwindow exec rpbarsend
EOF
	dodoc "${T}/ratpoisonrc.sample"
}
