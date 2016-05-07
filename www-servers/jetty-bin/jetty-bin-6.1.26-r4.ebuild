# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils java-pkg-2

DESCRIPTION="Jetty Web Server; Java Servlet container"

SLOT="6"
HOMEPAGE="http://jetty.codehaus.org/"
KEYWORDS="~amd64 ~x86"
LICENSE="Apache-2.0"

MY_PN="jetty"
#MY_JETTY="${PN}-${SLOT}"
MY_JETTY="${MY_PN}-${SLOT}"

IUSE="anttasks client ldap ssl stats tomcat7"

SRC_URI="http://dist.codehaus.org/jetty/jetty-${PV}/jetty-${PV}.zip
	anttasks? ( http://dist.codehaus.org/jetty/jetty-${PV}/jetty-ant-${PV}.jar )"
RESTRICT="mirror"

DEPEND="
	tomcat7? ( dev-java/tomcat-servlet-api:3.0 )
	!tomcat7? ( dev-java/tomcat-servlet-api:2.5 )
	!www-servers/jetty:${SLOT}
	!www-servers/jetty-eclipse:${SLOT}
	!www-servers/jetty-eclipse-bin:${SLOT}"

RDEPEND="${DEPEND}
	anttasks? ( dev-java/ant )
	>=dev-java/slf4j-api-1.3.1
	>=dev-java/sun-javamail-1.4
	>=dev-java/jta-1.0.1
	>=java-virtuals/jaf-1.1
	|| (
		virtual/jre:1.6
		virtual/jre:1.7
	 )"

S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {
	rm -f etc/jetty-sslengine.xml

	java-pkg_jarinto "/usr/share/${MY_JETTY}/lib/"
	java-pkg_sointo "/usr/lib/${MY_JETTY}"

	java-pkg_dojar start.jar
	java-pkg_newjar lib/${MY_PN}-${PV}.jar ${MY_PN}.jar
	java-pkg_newjar lib/${MY_PN}-util-${PV}.jar ${MY_PN}-util.jar
	java-pkg_newjar lib/jre1.5/${MY_PN}-util5-${PV}.jar ${MY_PN}-util5.jar
	java-pkg_newjar lib/annotations/${MY_PN}-annotations-${PV}.jar ${MY_PN}-annotations.jar
	java-pkg_newjar lib/ext/${MY_PN}-rewrite-handler-${PV}.jar ${MY_PN}-rewrite-handler.jar
	java-pkg_newjar lib/ext/${MY_PN}-html-${PV}.jar ${MY_PN}-html.jar
	java-pkg_newjar lib/ext/${MY_PN}-java5-threadpool-${PV}.jar ${MY_PN}-java5-threadpool.jar
	java-pkg_newjar lib/ext/${MY_PN}-ajp-${PV}.jar ${MY_PN}-ajp.jar
	java-pkg_newjar lib/ext/${MY_PN}-servlet-tester-${PV}.jar ${MY_PN}-servlet-tester.jar
	java-pkg_newjar lib/ext/${MY_PN}-setuid-${PV}.jar ${MY_PN}-setuid.jar
	java-pkg_doso   lib/ext/libsetuid.so
	java-pkg_newjar lib/jsp-2.1/jsp-2.1-${MY_PN}-${PV}.jar jsp-2.1-${MY_PN}.jar
	java-pkg_newjar lib/management/${MY_PN}-management-${PV}.jar ${MY_PN}-management.jar
	java-pkg_newjar lib/naming/${MY_PN}-naming-${PV}.jar ${MY_PN}-naming.jar
	java-pkg_newjar lib/plus/${MY_PN}-plus-${PV}.jar ${MY_PN}-plus.jar
	java-pkg_newjar lib/terracotta/${MY_PN}-terracotta-sessions-${PV}.jar ${MY_PN}-terracotta-sessions.jar
	java-pkg_newjar lib/xbean/${MY_PN}-xbean-${PV}.jar ${MY_PN}-xbean.jar

	use client && java-pkg_newjar lib/ext/${MY_PN}-client-${PV}.jar ${MY_PN}-client.jar
	if use ldap ; then
		 java-pkg_newjar lib/ext/${MY_PN}-ldap-jaas-${PV}.jar ${MY_PN}-ldap-jaas.jar
	else
		 rm -f etc/jetty-jaas.xml
	fi
	if use ssl ; then
		 java-pkg_newjar lib/ext/${MY_PN}-sslengine-${PV}.jar ${MY_PN}-sslengine.jar
	else
		 rm -f etc/jetty-ssl.xml
	fi
	if use stats ; then
		 java-pkg_newjar lib/ext/${MY_PN}-java5-stats-${PV}.jar ${MY_PN}-java5-stats.jar
	else
		 rm -f etc/jetty-stats.xml
	fi

	if use anttasks ; then
		 java-pkg_dojar bin/jetty-tasks.xml
		 cd "${DISTDIR}"
		 java-pkg_newjar ${MY_PN}-ant-${PV}.jar ${MY_PN}-ant.jar
		 cd "${S}"
	fi

	dodir /etc/${MY_JETTY}
	insinto /etc/${MY_JETTY}
	doins etc/*

	doconfd "${FILESDIR}/conf.d/${MY_JETTY}"
	doinitd "${FILESDIR}/init.d/${MY_JETTY}"

	dodir /var/log/${MY_JETTY}

	JETTY_HOME=/var/lib/${MY_JETTY}
	dodir ${JETTY_HOME}/webapps
	dodir ${JETTY_HOME}/contexts
	dodir ${JETTY_HOME}/resources
	dosym ${JAVA_PKG_JARDEST} ${JETTY_HOME}/lib
	dosym ${JAVA_PKG_JARDEST}/start.jar ${JETTY_HOME}/start.jar
	dosym /etc/${MY_JETTY} ${JETTY_HOME}/etc
	dosym /var/log/${MY_JETTY} ${JETTY_HOME}/logs

	START_CONFIG=${D}/${JETTY_HOME}/start.config
	cat >> "${START_CONFIG}" <<-EOF
\$(jetty.class.path).path                         always
\$(jetty.lib)/**                                  exists \$(jetty.lib)
jetty.home=${JETTY_HOME}
org.mortbay.xml.XmlConfiguration.class
\$(start.class).class
\$(jetty.home)/etc/jetty.xml
\$(jetty.home)/lib/*
/usr/share/sun-javamail/lib/*
/usr/share/ant/lib/*
/usr/share/slf4j-api/lib/*
/usr/share/jta/lib/*
/usr/share/tomcat-servlet-api-$(use tomcat7 && echo -n "3.0" || echo -n "2.5")/lib/*

\$(jetty.home)/resources/
EOF
}

pkg_preinst () {
	enewuser jetty
	fowners jetty:jetty /var/log/${MY_JETTY}
	fperms g+w /var/log/${MY_JETTY}
	mv "${D}/usr/share/${PN}-${SLOT}/package.env" "${D}/usr/share/${MY_JETTY}/package.env"
	rm -rf "${D}/usr/share/${PN}-${SLOT}"
}
