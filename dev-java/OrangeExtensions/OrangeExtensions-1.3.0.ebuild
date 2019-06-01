# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Stubs for the Apple Java Extensions"
HOMEPAGE="https://ymasory.github.io/OrangeExtensions/"
SRC_URI="https://github.com/ymasory/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=">=virtual/jre-1.5"
BDEPEND=">=virtual/jdk-1.5"

# This is needed because java-pkg-simple sets it to ${WORKDIR}
S="${WORKDIR}/OrangeExtensions-${PV}"

JAVAC_ARGS="-Xlint:unchecked -Xlint:deprecation"

JAVA_SRC_DIR="src"

# We don't install README.md because it's merely how to install.
# The developer uses Scala's SBT, but the project is pure Java and pure javac should work.
