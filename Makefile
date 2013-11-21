# Created by: Robert Nelson <robertn@the-nelsons.org>

# $FreeBSD$

PORTNAME=		emailrelay
PORTVERSION=		1.9.0.218
CATEGORIES=		mail
MASTER_SITES=		http://gforge.opensource-sw.net/gf/download/frsrelease/33/140/

MAINTAINER=		robertn@the-nelsons.org
COMMENT=		Simple SMTP proxy and store-and-forward MTA

USES=			pkgconfig
USE_AUTOTOOLS=		aclocal automake autoconf
USE_BZIP2=		yes
USE_RC_SUBR=		emailrelay

HAS_CONFIGURE=		yes

OPTIONS_DEFINE=		GUI DOXYGEN OPENSSL MAN2HTML DOCS
OPTIONS_DEFAULT=	GUI OPENSSL DOCS

OPTIONS_SUB=		yes

DOXYGEN_CONFIGURE_WITH=	doxygen

GUI_CONFIGURE_ENABLE=	gui
GUI_CONFIGURE_ENV=	e_qtmoc="${MOC}" e_spooldir=:"/var/spool/emailrelay"

MAN2HTML_CONFIGURE_WITH=man2html
MAN2HTML_BUILD_DEPENDS=	man2html:${PORTSDIR}/textproc/man2html

OPENSSL_CONFIGURE_WITH=	openssl

MAN2HTML_DESC=		HTML man pages

.include <bsd.port.options.mk>

CONFIGURE_ENV+=		e_spooldir=/var/spool/emailrelay
CONFIGURE_ARGS+=	--without-pam

.if ${PORT_OPTIONS:MGUI}
USE_QT4=		gui
.endif

.if ${PORT_OPTIONS:MOPENSSL}
USE_OPENSSL=		yes
.endif

pre-install:
	@mkdir -p ${STAGEDIR}/var/spool/emailrelay
	${CP} ${FILESDIR}/emailrelay.auth.template ${STAGEDIR}${PREFIX}/etc

.include <bsd.port.mk>
