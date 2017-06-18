# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils versionator git-r3

DESCRIPTION="CardDAV plugin for mail-client/thunderbird"
HOMEPAGE="http://www.sogo.nu/downloads/frontends.html"
THUNDERBIRD_VERSION="$(get_major_version )"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

EGIT_REPO_URI="https://github.com/inverse-inc/sogo-connector.tb31.git"
EGIT_COMMIT="b37cf92df945a23f97087b9d7665dac2146fe908"
#SRC_URI="https://github.com/inverse-inc/${PN}.tb${THUNDERBIRD_VERSION}/archive/${P}.tar.gz"

RDEPEND="|| ( =mail-client/thunderbird-45*[lightning] =mail-client/thunderbird-52*[lightning] )"

DEPEND="${RDEPEND}"
#S="${WORKDIR}/${PN}.tb${THUNDERBIRD_VERSION}-${P}"

src_prepare() {
        epatch "${FILESDIR}/makefile.patch"
}

src_install() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/thunderbird"

	emid=$(sed -n '/em:id=/!d; s/\s*em:id="//; s/"\s*//; p; q' install.rdf)

	dodir ${MOZILLA_FIVE_HOME}/extensions/${emid} || die
	cd "${ED}"${MOZILLA_FIVE_HOME}/extensions/${emid} || die
	unzip "${S}/${P}.xpi" || die
}
