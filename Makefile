# Created by: Robert Nelson <robertn@the-nelsons.org>
# $FreeBSD$

PORTNAME=		emailrelay
PORTVERSION=		1.9
CATEGORIES=		mail
MASTER_SITES=		SF
EXTRACT_SUFX=		-src.tar.gz

MAINTAINER=		robertn@the-nelsons.org
COMMENT=		Simple SMTP proxy and store-and-forward MTA

LICENSE=		GPLv3
LICENSE_FILE=		${WRKSRC}/COPYING

USES=			autoreconf pkgconfig
USE_RC_SUBR=		emailrelay

GNU_CONFIGURE=		yes

CONFIGURE_ENV=		e_spooldir=${PREFIX}/var/spool/emailrelay
CONFIGURE_ARGS=		--without-pam

OPTIONS_DEFINE=		DOCS DOXYGEN GUI MAN2HTML OPENSSL
OPTIONS_DEFAULT=	GUI OPENSSL

OPTIONS_SUB=		yes

DOXYGEN_CONFIGURE_WITH=	doxygen
DOXYGEN_BUILD_DEPENDS=	doxygen:${PORTSDIR}/devel/doxygen
DOXYGEN_DESC=		Build documentation with Doxygen (requires DOCS too)

GUI_CONFIGURE_ENABLE=	gui
GUI_CONFIGURE_ENV=	e_qtmoc="${MOC}"
GUI_USE=		QT4=gui

MAN2HTML_CONFIGURE_WITH=man2html
MAN2HTML_BUILD_DEPENDS=	man2html:${PORTSDIR}/textproc/man2html
MAN2HTML_DESC=		Regenerate HTML man pages (requires DOCS too)

OPENSSL_CONFIGURE_WITH=	openssl
OPENSSL_USE=		OPENSSL=yes

post-install:
	${MV} ${STAGEDIR}${PREFIX}/etc/emailrelay.auth.template ${STAGEDIR}${PREFIX}/etc/emailrelay.auth.sample
	${MV} ${STAGEDIR}${PREFIX}/etc/emailrelay.conf.template ${STAGEDIR}${PREFIX}/etc/emailrelay.conf.sample
	${RM} -r ${STAGEDIR}${PREFIX}/libexec/emailrelay/init

.include <bsd.port.mk>
