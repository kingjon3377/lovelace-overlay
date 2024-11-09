# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2

DESCRIPTION="Ant tasks needing commons-compress"
HOMEPAGE="https://ant.apache.org/antlibs/compress/index.html"
SRC_URI="mirror://apache/ant/antlibs/compress/source/apache-${P}-src.tar.gz"

S="${WORKDIR}/apache-${P}"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=virtual/jre-1.7:*
	dev-java/commons-compress:0
	>=dev-java/ant-1.7.0:0"
BDEPEND=">=virtual/jdk-1.7"
DEPEND="${RDEPEND}"

EANT_BUILD_TARGET="antlib"
EANT_DOC_TARGET="javadoc"

rewrite_build_xml() {
	python <<EOF
import xml.etree.cElementTree as et
tree = et.ElementTree(file='build.xml')
root = tree.getroot()
root.append(et.Element('path',id='test.classpath'))
root.append(et.Element('path',id='compile.classpath'))
skip=['resolve','classpath']
for target in tree.getiterator("target"):
	if target.attrib['name'] in skip:
		target.attrib['if'] = 'false'

tree.write('build.xml')
EOF
	[[ $? != 0 ]] && die "Removing taskdefs failed"
}

src_prepare() {
	find . -name "*.jar" -print -delete || die

	rewrite_build_xml
	default
}

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="ant,commons-compress"

src_install() {
	java-pkg_newjar "build/lib/${P}.jar" "${PN}.jar"
	java-pkg_register-ant-task
	use doc && java-pkg_dojavadoc build/javadoc
	use source && java-pkg_dosrc src/
	java-pkg_dohtml -r docs
}
