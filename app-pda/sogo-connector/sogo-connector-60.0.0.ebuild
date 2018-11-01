# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils versionator #git-r3

DESCRIPTION="CardDAV plugin for mail-client/thunderbird"
HOMEPAGE="http://www.sogo.nu/downloads/frontends.html"
THUNDERBIRD_VERSION="$(get_major_version )"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

SRC_URI="https://github.com/inverse-inc/${PN}/archive/${P}.tar.gz"

RDEPEND="=mail-client/thunderbird-60*[lightning]"

DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}.tb${THUNDERBIRD_VERSION}-${P}"

src_prepare() {
        epatch "${FILESDIR}/makefile.patch"
	epatch "${FILESDIR}/31.0.5-fix-version.patch"
	default
}

src_install() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/thunderbird"

	emid=$(sed -n '/em:id=/!d; s/\s*em:id="//; s/"\s*//; p; q' install.rdf)

	dodir ${MOZILLA_FIVE_HOME}/extensions/${emid} || die
	unzip "${P}.xpi" -d "${ED}"${MOZILLA_FIVE_HOME}/extensions/${emid}|| die
}
