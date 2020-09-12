# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

PATCH_TAR="${PN}-3.7.2-patches-01.tar.xz"

DESCRIPTION="A general-purpose (yacc-compatible) parser generator"
HOMEPAGE="https://www.gnu.org/software/bison/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz
	mirror://gentoo/${PATCH_TAR}
	https://dev.gentoo.org/~whissi/dist/bison/${PATCH_TAR}
	https://dev.gentoo.org/~polynomial-c/dist/bison/${PATCH_TAR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~ppc-aix ~x64-cygwin ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="examples nls static test"
RESTRICT="!test? ( test )"

RDEPEND=">=sys-devel/m4-1.4.16
	app-eselect/eselect-yacc"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/flex
	>=sys-devel/gettext-0.21
	examples? ( dev-lang/perl )
	test? ( dev-lang/perl )
"

DOCS=( AUTHORS ChangeLog NEWS README THANKS TODO ) # ChangeLog-2012 ChangeLog-1998 PACKAGING README-alpha README-release

PATCHES=(
	"${WORKDIR}"/patches/${PN}-3.5-optional-perl.patch #538300
	"${WORKDIR}"/patches/${PN}-3.7.2-avoid_autoreconf.patch
)

src_prepare() {
	# Record date to avoid 'config.status --recheck' & regen of 'tests/package.m4'
	touch -r configure.ac old.configure.ac || die
	touch -r configure old.configure || die

	default

	# Restore date after patching
	touch -r old.configure.ac configure.ac || die
	touch -r old.configure configure || die

	# The makefiles make the man page depend on the configure script
	# which we patched above.  Touch it to prevent regeneration.
	touch doc/bison.1 || die #548778 #538300#9

	# Avoid regenerating the info page when the timezone is diff. #574492
	sed -i '2iexport TZ=UTC' build-aux/mdate-sh || die
}

src_configure() {
	use static && append-ldflags -static

	local myeconfargs=(
		$(use_enable examples)
		$(use_enable nls)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default

	# This one is installed by dev-util/yacc
	mv "${ED}"/usr/bin/yacc{,.bison} || die
	mv "${ED}"/usr/share/man/man1/yacc{,.bison}.1 || die

	# We do not need liby.a
	rm -r "${ED}"/usr/lib* || die
}

pkg_postinst() {
	"${EROOT%/}/usr/bin/eselect" yacc update
}

pkg_postrm() {
	"${EROOT%/}/usr/bin/eselect" yacc update
}