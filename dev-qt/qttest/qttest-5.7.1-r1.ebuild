# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
QT5_MODULE="qtbase"
QT5_MODULE_EXAMPLES_SUBDIRS=("examples/qtestlib")
VIRTUALX_REQUIRED="test"
inherit qt5-build

DESCRIPTION="Unit testing library for the Qt5 framework"

if [[ ${QT5_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~x86"
fi

IUSE=""

RDEPEND="
	~dev-qt/qtcore-${PV}
"
DEPEND="${RDEPEND}
	examples? (
		~dev-qt/qtgui-${PV}
		~dev-qt/qtwidgets-${PV}
	)
	test? (
		~dev-qt/qtgui-${PV}
		~dev-qt/qtxml-${PV}
	)
"

QT5_TARGET_SUBDIRS=(
	src/testlib
)
