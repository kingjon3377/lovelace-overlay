# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Ant tasks needing commons-compress"
HOMEPAGE="https://ant.apache.org/antlibs/compress/index.html"
SRC_URI="mirror://apache/ant/antlibs/compress/source/apache-${P}-src.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

RDEPEND=">=virtual/jre-1.5
	dev-java/commons-compress:0
	>=dev-java/ant-core-1.7.0:0"
DEPEND=">=virtual/jdk-1.5
  ${RDEPEND}"

EANT_BUILD_TARGET="antlib"
EANT_DOC_TARGET="javadoc"

S="${WORKDIR}/apache-${P}"

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

java_prepare() {
	find . -name "*.jar" -print -delete || die

	rewrite_build_xml
}

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="ant-core,commons-compress"

src_install() {
	java-pkg_newjar "build/lib/${P}.jar" "${PN}.jar"
	java-pkg_register-ant-task
	use doc && java-pkg_dojavadoc build/javadoc
	use source && java-pkg_dosrc src/
	java-pkg_dohtml -r docs
}
