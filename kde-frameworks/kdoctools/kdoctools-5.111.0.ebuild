# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_QTHELP="false"
inherit kde5

DESCRIPTION="Tools to generate documentation in various formats from DocBook files"
LICENSE="MIT"
KEYWORDS="*"
IUSE="nls"

BDEPEND="
	dev-lang/perl
	dev-perl/URI
	nls? ( $(add_frameworks_dep ki18n) )
"
DEPEND="
	app-text/docbook-xml-dtd:4.5
	app-text/docbook-xsl-stylesheets
	app-text/sgml-common
	dev-libs/libxml2:2
	dev-libs/libxslt
	$(add_frameworks_dep karchive)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package nls KF5I18n)
	)

	kde5_src_configure
}

src_test() {
	# bug 665622
	local myctestargs=(
		-E "(kdoctools_install)"
	)

	kde5_src_test
}