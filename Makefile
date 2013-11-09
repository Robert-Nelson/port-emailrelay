PORTNAME=		emailrelay
PORTVERSION=		1.9.0.212
CATEGORIES=		mail
MASTER_SITES=		http://gforge.opensource-sw.net/gf/download/frsrelease/33/138/

MAINTAINER=		robertn@the-nelsons.org
COMMENT=		Simple SMTP proxy and store-and-forward message transfer agent (MTA)

USES=			pkgconfig
USE_AUTOTOOLS=		aclocal automake autoconf
USE_QT4=		gui
USE_BZIP2=		yes

HAS_CONFIGURE=		yes
CONFIGURE_ENV=

OPTIONS_DEFINE=		GUI DOXYGEN OPENSSL MAN2HTML DOCS
OPTIONS_DEFAULT=	GUI OPENSSL

MAN2HTML_DESC=		HTML man pages

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MGUI}
CONFIGURE_ARGS+=--enable-gui
PLIST_FILES+=share/emailrelay/emailrelay-icon.png
.else
CONFIGURE_ARGS+=--disable-gui
.endif

.if ${PORT_OPTIONS:MDOXYGEN}
PLIST_FILES+= 	share/doc/emailrelay/doxygen/emailrelay-doxygen.css \
		share/doc/emailrelay/doxygen/index.html
CONFIGURE_ARGS+=--with-doxygen
.else
CONFIGURE_ARGS+=--without-doxygen
.endif

.if ${PORT_OPTIONS:MOPENSSL}
USE_OPENSSL=yes
CONFIGURE_ARGS+=--with-openssl
.else
CONFIGURE_ARGS+=--without-openssl
.endif

.if ${PORT_OPTIONS:MMAN2HTML}
BUILD_DEPENDS=man2html:${PORTSDIR}/textproc/man2html
CONFIGURE_ARGS+=--with-man2html
.else
CONFIGURE_ARGS+=--without-man2html
.endif

.if ${PORT_OPTIONS:MDOCS}
PLIST_FILES+= 	share/doc/emailrelay/developer.txt \
	share/doc/emailrelay/reference.txt \
	share/doc/emailrelay/userguide.txt \
	share/doc/emailrelay/windows.txt \
	share/doc/emailrelay/readme.html \
	share/doc/emailrelay/developer.html \
	share/doc/emailrelay/reference.html \
	share/doc/emailrelay/userguide.html \
	share/doc/emailrelay/windows.html \
	share/doc/emailrelay/changelog.html \
	share/doc/emailrelay/index.html \
	share/doc/emailrelay/emailrelay-man.html \
	share/doc/emailrelay/emailrelay.css \
	share/doc/emailrelay/emailrelay-doxygen.css \
	share/doc/emailrelay/gsmtp-classes.png \
	share/doc/emailrelay/gnet-classes.png \
	share/doc/emailrelay/sequence-3.png \
	share/doc/emailrelay/gnet-client.png \
	share/doc/emailrelay/gsmtp-serverprotocol.png \
	share/doc/emailrelay/auth.png \
	share/doc/emailrelay/valid-html401.png \
	share/doc/emailrelay/diagram-1.png \
	share/doc/emailrelay/diagram-2.png \
	share/doc/emailrelay/emailrelay.docbook
.endif

post-install:
	@if [ ! -f ${PREFIX}/etc/emailrealy.conf ]; then \
		${CP} -p ${PREFIX}/etc/emailrelay.conf.template ${PREFIX}/etc/emailrelay.conf ; \
	fi

.include <bsd.port.mk>
