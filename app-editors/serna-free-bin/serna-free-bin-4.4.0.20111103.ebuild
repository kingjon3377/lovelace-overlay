# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# Ebuild developed by urs@linurs.org using http://www.linurs.org/ebuildtool.htm
# Use this ebuild on your own risk license
# This ebuild installs the binary version of serna free on Gentoo
inherit eutils versionator

DESCRIPTION="Serna free is a WYSIWYG XML editor"
#SRC_URI="http://downloads.syntext.com/serna-free/4.4.0-RELEASE/serna-free-$(replace_version_separator 3 -)-linux.tgz"
SRC_URI="mirror://sourceforge/sernafree.mirror/serna-free-$(replace_version_separator 3 -)-linux.tgz"
HOMEPAGE="http://www.syntext.com"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-arch/tar
	app-arch/gzip
	app-doc/doxygen
	sys-devel/flex
	sys-devel/bison"
# This is packages providing files that serna bundles by default. qscintilla and
# qt-qt3support aren't included in any emul-linux-x86-* packages.
SERNA_PROVIDED_FILES="dev-qt/qthelp:4
	dev-libs/libxslt
	amd64? ( app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-qtlibs
		app-emulation/emul-linux-x86-java )
	virtual/libiconv
	x11-libs/qscintilla
	dev-qt/qt3support:4
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtsql:4
	dev-qt/qtsvg:4
	dev-libs/libxml2
	dev-lang/python:2.6
	virtual/jre:1.6
	dev-python/sip
	dev-python/pyqwt
	dev-python/PyQt4
	"
# This is just the "DEPEND" of my source ebuild copied to RDEPEND; some of these
# may not be needed at runtime. And as this is a binary package, likely
# x86-only, we probably need emul-x86-* equivalents instead ...
RDEPEND="${SERNA_PROVIDED_FILES}
	dev-java/antlr:0
	app-text/aspell
	app-text/docbook-xsl-stylesheets
	dev-python/sip
	dev-lang/perl
	x11-libs/libX11
	sys-libs/zlib
	sys-libs/ncurses
	app-text/docbook-sgml-utils
	app-text/hunspell"

src_install() {
# The following follows the serna-free installer and has been converted to an
# ebuild; it does not require input from the user.  Since Gentoo installs first
# in a temporary directory and then merges it into the real root, two sets of
# variables are required: The original serna variables point to the Gentoo work
# directory, while POST_* variables point to the real root directory.
	POST_INSTALLDIR=/opt

	DEF_INSTALLDIR=${D}${POST_INSTALLDIR}
	DEF_RUNDIR=${D}${POST_INSTALLDIR}/bin

# The serena-free version numbering is not consistent.
# From the outside it is 4.4.0 but if it comes to the installer it is just 4.4.  
	SERNA_NAME=serna-free
	SERNA_SCRIPT=${SERNA_NAME}-4.4
	SERNA_DIR=${SERNA_NAME}-4.4
	SERNA_TGZ=${SERNA_DIR}.tgz

	INSTALL_PREFIX=$DEF_INSTALLDIR
	POST_INSTALL_PREFIX=$POST_INSTALLDIR
	RUNDIR=${INSTALL_PREFIX}/bin
	POST_RUNDIR=${POST_INSTALL_PREFIX}/bin
	SERNA=${INSTALL_PREFIX}/${SERNA_DIR}

	einfo "Serna will be installed in INSTALL_PREFIX $POST_INSTALLDIR"
	dodir $POST_INSTALLDIR
	einfo "Serna will run in DEF_RUNDIR $POST_RUNDIR"
	dodir $POST_RUNDIR
	einfo "Installing Serna to INSTALL_PREFIX/SERNA_DIR: ${INSTALL_PREFIX}/${SERNA_DIR}"
	einfo "Change to INSTALL_PREFIX $INSTALL_PREFIX"
	cd $INSTALL_PREFIX

	PKGDIR=${WORKDIR}/${SERNA_DIR}
	einfo "PKGDIR $PKGDIR"
	einfo "SERNA_TGZ $SERNA_TGZ"
	SERNA_TGZ_PATH=${PKGDIR}/$SERNA_TGZ
	einfo "Unpack file SERNA_TGZ_PATH $SERNA_TGZ_PATH"
	tar xzf $SERNA_TGZ_PATH

	SERNA_TAG=${SERNA_NAME}-4.4
	SERNA_EXE=serna.bin

# The serna installer called a post installer to be run outside the sandbox.
# This is possible with gentoo ebuilds as well, but not clean since the system
# does not notice how the post installer modifies the system.  Orphan files are
# created that might cause package collision in future updates.  Therefore the
# post installer is included in this ebuild and runs in the sandbox.
	einfo "Run the post installer in the sandbox."
	RUNDIR=$POST_RUNDIR

	einfo "The following is exported to the post-installer"
	einfo "SERNA_TAG $SERNA_TAG"
	einfo "INSTALL_PREFIX $INSTALL_PREFIX"
	einfo "SERNA_EXE $SERNA_EXE"

	export SERNA_TAG INSTALL_PREFIX SERNA_EXE

	POSTIN=${INSTALL_PREFIX}/${SERNA_DIR}/bin/serna-postin.sh
	einfo "POSTIN $POSTIN"

# Instead of calling the post installer with [ -x ${POSTIN} ] && ${POSTIN}, 
# the post installer code follows here

	for v in SERNA_TAG SERNA_EXE INSTALL_PREFIX; do
		eval test -z \$$v && echo "Variable $v is not set!" && exit 1
	done

	SERNA_SCRIPT=${INSTALL_PREFIX}/${SERNA_TAG}/bin/serna.sh
	einfo "SERNA_SCRIPT $SERNA_SCRIPT"

# The following is the script the post installer creates; it is executed
# when you later run serna.  The script is now produced within the sandbox. 
	cat << EOF > ${SERNA_SCRIPT}
#!/bin/sh 
inst_prefix=${POST_INSTALLDIR}
export SERNA_DATA_DIR=\${inst_prefix}/${SERNA_TAG}
LD_LIBRARY_PATH=\${SERNA_DATA_DIR}/bin:\${SERNA_DATA_DIR}/lib:\${SERNA_DATA_DIR}/python/lib:\${LD_LIBRARY_PATH}

[ x\${AXF4_HOME} = x ] && AXF4_HOME=/usr/XSLFormatterV4

[ -e \${AXF4_HOME}/lib/libXfoInterface.so ] && LD_LIBRARY_PATH=\${LD_LIBRARY_PATH}:\${AXF4_HOME}/lib
export LD_LIBRARY_PATH

AXF4_LIB_FOLDER=\${AXF4_HOME}/lib
AXF4_BIN_FOLDER=\${AXF4_HOME}/bin
AXF4_ETC_FOLDER=\${AXF4_HOME}/etc
AXF4_SDATA_FOLDER=\${AXF4_HOME}/sdata

if [ x\${AXF4_FONT_CONFIGFILE} = x ]; then
	[ -f \${AXF4_ETC_FOLDER}/font-config.xml ] && AXF4_FONT_CONFIGFILE=\${AXF4_ETC_FOLDER}/font-config.xml
	export AXF4_FONT_CONFIGFILE
fi

export AXF4_LIC_PATH=\${AXF4_ETC_FOLDER}
export AXF4_HYPDIC_PATH=\${AXF4_ETC_FOLDER}/hyphenation
export AXF4_DMC_TBLPATH=\${AXF4_SDATA_FOLDER}/base2

export JAVA_HOME=\${SERNA_DATA_DIR}/jre

exec \${SERNA_DATA_DIR}/bin/${SERNA_EXE} "\$@"
EOF
# After the above EOF the script is finished and can be called later

	SERNA_DIR=${INSTALL_PREFIX}/${SERNA_TAG}
	einfo "SERNA_DIR $SERNA_DIR"

	chmod 755 ${SERNA_SCRIPT}
	chmod 755 ${SERNA_DIR}/utils/publishing/*.sh

	RUNDIR=${INSTALL_PREFIX}/bin
	einfo "RUNDIR $RUNDIR"

	if [ -e ${RUNDIR}/serna ]; then
		rm -f ${RUNDIR}/${SERNA_TAG}.backup
		mv ${RUNDIR}/serna ${RUNDIR}/${SERNA_TAG}.backup
	fi
	dosym ../${SERNA_TAG}/bin/serna.sh ${POST_RUNDIR}/${SERNA_TAG}
	dosym ${SERNA_TAG} ${POST_RUNDIR}/serna

# End of the code from the post installer 

	chmod 755 ${SERNA_DIR}/bin/${SERNA_EXE}
	chmod 755 ${SERNA_SCRIPT}
	chmod -R a+r $SERNA
	chmod a+x `find $SERNA -type d`

	einfo "Installation is finished."

	rm "${SERNA}/bin/assistant" "${SERNA}/bin/libexslt.so.0" \
		"${SERNA}/bin/libiconv.so.2" "${SERNA}/bin/libqscintilla2.so.5" \
		"${SERNA}/bin/libQt3Support.so" "${SERNA}/bin/libQt3Support.so.4" \
		"${SERNA}/bin/libQtAssistantClient.so" "${SERNA}/bin/libQtCLucene.so" \
		"${SERNA}/bin/libQtAssistantClient.so.4" "${SERNA}/bin/libQtCore.so" \
		"${SERNA}/bin/libQtCLucene.so.4" "${SERNA}/bin/libQtCore.so.4" \
		"${SERNA}/bin/libQtGui.so" "${SERNA}/bin/libQtGui.so.4" \
		"${SERNA}/bin/libQtHelp.so" "${SERNA}/bin/libQtHelp.so.4" \
		"${SERNA}/bin/libQtNetwork.so" "${SERNA}/bin/libQtNetwork.so.4" \
		"${SERNA}/bin/libQtSql.so" "${SERNA}/bin/libQtSql.so.4" \
		"${SERNA}/bin/libQtSvg.so" "${SERNA}/bin/libQtSvg.so.4" \
		"${SERNA}/bin/libQtXml.so" "${SERNA}/bin/libQtXml.so.4" \
		"${SERNA}/bin/libxml2.so.2" "${SERNA}/bin/libxslt.so.1" \
		"${SERNA}/bin/linguist" "${SERNA}/bin/lrelease" \
		"${SERNA}/bin/xsltproc" "${SERNA}/bin/imageformats/libqgif.so" \
		"${SERNA}/bin/imageformats/libqjpeg.so" \
		"${SERNA}/bin/imageformats/libqsvg.so" \
		"${SERNA}/bin/imageformats/libqtiff.so" \
		"${SERNA}/plugins/speller/libaspell.so" \
		"${SERNA}/plugins/speller/libhunspell.so" \
		|| die "removing bundled files failed"
	rmdir "${SERNA}/bin/imageformats" || die "missed some files"
	rm -r "${SERNA}/jre" || die "removing bundled JRE failed"
	rm -r "${SERNA}/python/include" || \
		die "removing bundled python headers failed"
	rm "${SERNA}/python/lib/libpython2.6.so" \
		"${SERNA}/python/lib/libpython2.6.so.1.0" \
		"${SERNA}/plugins/pyplugin/sip.so" \
		|| die "removing bundled python libs etc. failed"
	rm -r "${SERNA}/plugins/pyplugin/PyQt4" || \
		die "removing bundled PyQt4 failed"
	for a in SimpleXMLRPCServer _MozillaCookieJar Cookie copy cProfile csv \
		copy_reg dbhash dircache decimal doctest difflib dis dumbdbm cookielib \
		dummy_threading ConfigParser filecmp dummy_thread contextlib \
		DocXMLRPCServer genericpath __future__ fnmatch functools fractions \
		ftplib getpass fileinput gettext getopt fpformat formatter \
		htmlentitydefs hmac httplib glob imaplib colorsys commands hashlib \
		imghdr imputil HTMLParser collections htmllib gzip compileall ihooks \
		heapq linecache macpath _LWPCookieJar io keyword inspect codecs codeop \
		locale code macurl2path pipes py_compile os2emxpath posixfile \
		__phello__.foo popen2 pdb platform profile pty pstats pprint pickle \
		plistlib posixpath pkgutil os pickletools pyclbr poplib statvfs cmd \
		cgitb sched bisect binhex opcode re sha mailbox rfc822 bdb markupbase \
		runpy quopri rexec stat mailcap pydoc_topics repr robotparser numbers \
		optparse sgmllib chunk pydoc sets rlcompleter md5 Queue random cgi \
		calendar CGIHTTPServer asynchat mimetools atexit audiodev base64 mhlib \
		Bastion mimetypes ast BaseHTTPServer anydbm asyncore MimeWriter mutex \
		SocketServer sndhdr new sre_constants netrc smtpd sre_compile shutil \
		ntpath shlex socket nntplib sre_parse nturl2path shelve site smtplib \
		SimpleHTTPServer sunaudio textwrap stringprep _threading_local symbol \
		subprocess string traceback this threading toaiff tarfile token struct \
		tabnanny tempfile sunau _strptime tokenize symtable timeit telnetlib \
		xmllib UserDict xdrlib urllib2 wave xmlrpclib zipfile whichdb warnings \
		UserString UserList user urlparse uuid webbrowser uu urllib weakref \
		_abcoll trace multifile tty unittest StringIO stringold abc aifc \
		mimify modulefinder ssl sre types compiler/misc compiler/visitor \
		compiler/transformer compiler/__init__ compiler/syntax \
		compiler/pyassem compiler/symbols compiler/pycodegen compiler/future \
		compiler/consts compiler/ast ctypes/macholib/__init__ \
		ctypes/macholib/dyld ctypes/macholib/framework ctypes/macholib/dylib \
		ctypes/__init__ ctypes/wintypes ctypes/util ctypes/_endian \
		email/mime/multipart email/mime/nonmultipart email/mime/__init__ \
		email/mime/audio email/mime/text email/mime/image email/mime/message \
		email/mime/application email/mime/base email/parser email/header \
		email/__init__ email/errors email/utils email/iterators email/message \
		email/generator email/quoprimime email/base64mime email/_parseaddr \
		email/feedparser email/encoders email/charset encodings/cp737 \
		encodings/cp852 encodings/cp424 encodings/cp1251 encodings/cp775 \
		encodings/cp1258 encodings/cp857 encodings/cp500 encodings/cp1252 \
		encodings/cp856 encodings/cp1253 encodings/cp1254 encodings/cp1256 \
		encodings/cp1250 encodings/cp1255 encodings/cp855 encodings/cp1257 \
		encodings/cp437 encodings/cp1026 encodings/cp1140 encodings/cp1006 \
		encodings/cp850 encodings/hp_roman8 encodings/gbk encodings/cp950 \
		encodings/iso2022_jp_2004 encodings/__init__ encodings/iso2022_jp_ext \
		encodings/cp949 encodings/hz encodings/iso2022_jp_3 encodings/euc_kr \
		encodings/gb18030 encodings/hex_codec encodings/euc_jis_2004 \
		encodings/gb2312 encodings/cp875 encodings/idna encodings/cp932 \
		encodings/euc_jisx0213 encodings/cp874 encodings/euc_jp \
		encodings/iso2022_jp_1 encodings/iso2022_jp_2 encodings/cp037 \
		encodings/big5 encodings/cp866 encodings/base64_codec \
		encodings/iso8859_15 encodings/cp869 encodings/iso8859_14 \
		encodings/cp860 encodings/iso8859_16 encodings/iso8859_11 \
		encodings/cp861 encodings/big5hkscs encodings/cp864 encodings/charmap \
		encodings/ascii encodings/iso2022_jp encodings/iso8859_13 \
		encodings/cp862 encodings/iso8859_10 encodings/cp863 \
		encodings/iso2022_kr encodings/aliases encodings/bz2_codec \
		encodings/cp865 encodings/mac_iceland encodings/koi8_r \
		encodings/mac_turkish encodings/mac_latin2 encodings/iso8859_1 \
		encodings/iso8859_9 encodings/mac_arabic encodings/mac_cyrillic \
		encodings/mac_roman encodings/iso8859_8 encodings/mac_croatian \
		encodings/mac_romanian encodings/iso8859_7 encodings/iso8859_2 \
		encodings/johab encodings/mac_greek encodings/iso8859_6 \
		encodings/iso8859_5 encodings/mac_centeuro encodings/mac_farsi \
		encodings/koi8_u encodings/iso8859_3 encodings/iso8859_4 \
		encodings/latin_1 encodings/raw_unicode_escape encodings/tis_620 \
		encodings/shift_jis encodings/shift_jis_2004 encodings/punycode \
		encodings/palmos encodings/rot_13 encodings/ptcp154 \
		encodings/shift_jisx0213 encodings/unicode_escape encodings/mbcs \
		encodings/quopri_codec encodings/string_escape encodings/undefined \
		encodings/unicode_internal encodings/utf_8_sig encodings/utf_32_le \
		encodings/utf_8 encodings/utf_7 encodings/utf_16_be \
		encodings/utf_32_be encodings/zlib_codec encodings/uu_codec \
		encodings/utf_16 encodings/utf_16_le encodings/utf_32 hotshot/__init__ \
		hotshot/stones hotshot/log hotshot/stats idlelib/CodeContext \
		idlelib/ColorDelegator idlelib/dynOptionMenuWidget idlelib/AutoExpand \
		idlelib/AutoCompleteWindow idlelib/Delegator idlelib/CallTipWindow \
		idlelib/configSectionNameDialog idlelib/CallTips idlelib/Debugger \
		idlelib/EditorWindow idlelib/configHandler idlelib/Bindings \
		idlelib/ClassBrowser idlelib/configHelpSourceEdit idlelib/configDialog \
		idlelib/GrepDialog idlelib/keybindingDialog idlelib/ParenMatch \
		idlelib/__init__ idlelib/IOBinding idlelib/MultiCall \
		idlelib/ObjectBrowser idlelib/PathBrowser idlelib/macosxSupport \
		idlelib/MultiStatusBar idlelib/FormatParagraph idlelib/HyperParser \
		idlelib/idlever idlelib/OutputWindow idlelib/idle idlelib/IdleHistory \
		idlelib/tabbedpages idlelib/WidgetRedirector idlelib/TreeWidget \
		idlelib/RemoteObjectBrowser idlelib/ReplaceDialog idlelib/SearchEngine \
		idlelib/RemoteDebugger idlelib/UndoDelegator idlelib/run \
		idlelib/SearchDialogBase idlelib/PyShell idlelib/ToolTip \
		idlelib/ScriptBinding idlelib/rpc idlelib/WindowList \
		idlelib/ScrolledList idlelib/StackViewer idlelib/textView \
		idlelib/SearchDialog idlelib/ZoomHeight idlelib/AutoComplete \
		idlelib/PyParse idlelib/FileList idlelib/aboutDialog \
		idlelib/Percolator json/tool json/__init__ json/decoder json/encoder \
		json/scanner lib2to3/fixer_base lib2to3/__init__ lib2to3/main \
		lib2to3/fixer_util lib2to3/pytree lib2to3/pygram lib2to3/patcomp \
		lib2to3/refactor lib2to3/fixes/fix_getcwdu lib2to3/fixes/fix_imports \
		lib2to3/fixes/__init__ lib2to3/fixes/fix_exec \
		lib2to3/fixes/fix_metaclass lib2to3/fixes/fix_itertools \
		lib2to3/fixes/fix_except lib2to3/fixes/fix_intern \
		lib2to3/fixes/fix_imports2 lib2to3/fixes/fix_dict \
		lib2to3/fixes/fix_import lib2to3/fixes/fix_next \
		lib2to3/fixes/fix_apply lib2to3/fixes/fix_future \
		lib2to3/fixes/fix_methodattrs lib2to3/fixes/fix_filter \
		lib2to3/fixes/fix_isinstance lib2to3/fixes/fix_long \
		lib2to3/fixes/fix_input lib2to3/fixes/fix_funcattrs \
		lib2to3/fixes/fix_itertools_imports lib2to3/fixes/fix_buffer \
		lib2to3/fixes/fix_map lib2to3/fixes/fix_basestring \
		lib2to3/fixes/fix_idioms lib2to3/fixes/fix_renames \
		lib2to3/fixes/fix_has_key lib2to3/fixes/fix_ne \
		lib2to3/fixes/fix_callable lib2to3/fixes/fix_execfile \
		lib2to3/fixes/fix_raw_input lib2to3/fixes/fix_reduce \
		lib2to3/fixes/fix_raise lib2to3/fixes/fix_paren \
		lib2to3/fixes/fix_nonzero lib2to3/fixes/fix_numliterals \
		lib2to3/fixes/fix_print lib2to3/fixes/fix_urllib lib2to3/fixes/fix_zip \
		lib2to3/fixes/fix_xreadlines lib2to3/fixes/fix_standarderror \
		lib2to3/fixes/fix_tuple_params lib2to3/fixes/fix_sys_exc \
		lib2to3/fixes/fix_types lib2to3/fixes/fix_repr \
		lib2to3/fixes/fix_ws_comma lib2to3/fixes/fix_set_literal \
		lib2to3/fixes/fix_unicode lib2to3/fixes/fix_xrange logging/config \
		lib2to3/fixes/fix_throw lib2to3/pgen2/__init__ lib2to3/pgen2/conv \
		lib2to3/pgen2/parse lib2to3/pgen2/grammar lib2to3/pgen2/literals \
		lib2to3/pgen2/token lib2to3/pgen2/driver lib2to3/pgen2/pgen \
		lib2to3/pgen2/tokenize logging/__init__ logging/handlers \
		multiprocessing/dummy/connection multiprocessing/dummy/__init__ \
		multiprocessing/connection multiprocessing/__init__ \
		multiprocessing/process multiprocessing/util multiprocessing/pool \
		multiprocessing/heap multiprocessing/managers multiprocessing/queues \
		multiprocessing/sharedctypes multiprocessing/forking \
		multiprocessing/reduction multiprocessing/synchronize \
		plat-linux2/TYPES plat-linux2/IN plat-linux2/CDROM plat-linux2/DLFCN \
		wsgiref/headers wsgiref/__init__ wsgiref/simple_server wsgiref/util \
		wsgiref/validate wsgiref/handlers xml/dom/NodeFilter xml/dom/__init__ \
		xml/dom/domreg xml/dom/expatbuilder xml/dom/minicompat xml/dom/pulldom \
		xml/dom/minidom xml/dom/xmlbuilder xml/etree/cElementTree \
		xml/etree/ElementPath xml/etree/__init__ xml/etree/ElementTree \
		xml/etree/ElementInclude xml/parsers/__init__ xml/parsers/expat \
		xml/sax/__init__ xml/sax/saxutils xml/sax/xmlreader xml/sax/handler \
		xml/sax/expatreader xml/sax/_exceptions xml/__init__ \
		site-packages/libxml2 site-packages/drv_libxml2 site-packages/libxslt
	do
		rm "${SERNA}/python/lib/python2.6/${a}.py" || \
			die "removing bundled Python file ${a} failed"
	done
	for a in ctypes/macholib/fetch_macholib.bat ctypes/macholib/README.ctypes \
		ctypes/macholib/fetch_macholib idlelib/ChangeLog idlelib/README.txt \
		idlelib/CREDITS.txt idlelib/HISTORY.txt idlelib/config-keys.def \
		idlelib/help.txt idlelib/TODO.txt idlelib/config-extensions.def \
		idlelib/NEWS.txt idlelib/config-highlight.def idlelib/extend.txt \
		idlelib/idle.pyw idlelib/config-main.def idlelib/idle.bat \
		idlelib/Icons/plusnode.gif idlelib/Icons/python.gif \
		idlelib/Icons/folder.gif idlelib/Icons/idle.icns idlelib/Icons/tk.gif \
		idlelib/Icons/minusnode.gif idlelib/Icons/openfolder.gif \
		lib2to3/Grammar.txt lib2to3/PatternGrammar.txt site-packages/README \
		lib2to3/Grammar2.6.2.final.0.pickle wsgiref.egg-info pdb.doc \
		lib2to3/PatternGrammar2.6.2.final.0.pickle plat-linux2/regen \
		site-packages/libxml2mod.so site-packages/libxsltmod.so \
		lib-dynload/_codecs_iso2022.so lib-dynload/cStringIO.so \
		lib-dynload/_bytesio.so lib-dynload/_ctypes_test.so \
		lib-dynload/audioop.so lib-dynload/binascii.so lib-dynload/cmath.so \
		lib-dynload/_codecs_hk.so lib-dynload/crypt.so lib-dynload/_csv.so \
		lib-dynload/_collections.so lib-dynload/_codecs_tw.so \
		lib-dynload/_codecs_kr.so lib-dynload/_codecs_cn.so lib-dynload/bz2.so \
		lib-dynload/_codecs_jp.so lib-dynload/_ctypes.so lib-dynload/array.so \
		lib-dynload/_bisect.so lib-dynload/_multiprocessing.so \
		lib-dynload/future_builtins.so lib-dynload/_hotshot.so \
		lib-dynload/mmap.so lib-dynload/linuxaudiodev.so \
		lib-dynload/itertools.so lib-dynload/_fileio.so \
		lib-dynload/datetime.so lib-dynload/grp.so lib-dynload/_elementtree.so \
		lib-dynload/math.so lib-dynload/_json.so lib-dynload/_lsprof.so \
		lib-dynload/_multibytecodec.so lib-dynload/_locale.so \
		lib-dynload/_functools.so lib-dynload/_heapq.so lib-dynload/fcntl.so \
		lib-dynload/_random.so lib-dynload/parser.so lib-dynload/termios.so \
		lib-dynload/spwd.so lib-dynload/select.so lib-dynload/ossaudiodev.so \
		lib-dynload/syslog.so lib-dynload/_socket.so lib-dynload/operator.so \
		lib-dynload/_weakref.so lib-dynload/_struct.so lib-dynload/resource.so \
		lib-dynload/nis.so lib-dynload/time.so lib-dynload/unicodedata.so \
		lib-dynload/_testcapi.so lib-dynload/pyexpat.so lib-dynload/zlib.so \
		lib-dynload/strop.so lib-dynload/Python-2.6.2-py2.6.egg-info \
		lib-dynload/cPickle.so lib-dynload/dl.so lib-dynload/imageop.so
	do
		rm "${SERNA}/python/lib/python2.6/${a}" \
			|| die "removing bundled Python file ${a} failed"
	done
	rm "${SERNA}/LIBICONV-COPYING" "${SERNA}/XSLTPROC-COPYING" \
		"${SERNA}/python/lib/python2.6/LICENSE.txt" || \
		die "Removing licenses for libs we don't bundle failed"
	rm "${SERNA}/LICENSE.GPL" || die "removing license file failed"
	rm -r "${SERNA}/xml/stylesheets"||die "removing bundled stylesheets failed"
	for a in compiler ctypes/macholib ctypes email/mime email encodings \
		hotshot idlelib/Icons idlelib json lib2to3/fixes lib2to3/pgen2 lib2to3 \
		multiprocessing/dummy multiprocessing logging plat-linux2 wsgiref \
		xml/dom xml/etree xml/parsers xml/sax xml site-packages lib-dynload
	do
		rmdir "${SERNA}/python/lib/python2.6/${a}" || \
			die "missed some files in ${SERNA}/python/lib/python2.6/${a}"
	done
	rmdir "${SERNA}/python/lib/python2.6" "${SERNA}/python/lib" \
		"${SERNA}/python" || die "missed some files"

	dodir /usr/share/doc
	mv "${SERNA}/doc" "${D}/usr/share/doc/${P}" || \
		die "moving documentation failed"
	mv "${SERNA}/EULA.txt" "${SERNA}/examples" "${SERNA}/GPL_EXCEPTION.txt" \
		"${SERNA}/SP-COPYING" -i "${D}/usr/share/doc/${P}" || \
		die "moving extra docs into doc directory failed"

	trap 0
}

pkg_postinst() {
	ewarn 'We *really* ought to unpack in the unpack step and just cherry-pick'
	ewarn 'files to install, rather than unpacking in the install step directly'
	ewarn 'in ${D}.'
	ewarn
	ewarn "I'd much prefer to build from source, but it's impossible to do so"
	ewarn "using system packages instead of building dependencies in the build"
	ewarn "process---and some of them aren't in Portage anyway."
	ewarn
	ewarn "What's worse, the source has entirely vanished from the Net; this"
	ewarn "binary version was what Sourceforge picked up to mirror."
	ewarn
	ewarn "The config templates refer to bundled files that we removed."
	ewarn
	ewarn "And we're most likely missing some emul-linux-* dependencies."
}
