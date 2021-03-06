# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Abtraction layer for PyQt5/PyQt4/PySide"
HOMEPAGE="https://github.com/spyder-ide/qtpy"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="designer gui opengl pyqt4 +pyqt5 pyside svg testlib webkit"

REQUIRED_USE="|| ( pyqt4 pyqt5 pyside )"

RDEPEND="
	pyqt4? (
		dev-python/PyQt4[${PYTHON_USEDEP},designer?,opengl?,svg?,webkit?]
		gui? ( dev-python/PyQt4[${PYTHON_USEDEP},X] )
		testlib? ( dev-python/PyQt4[${PYTHON_USEDEP},testlib] )
	)
	pyqt5? (
		dev-python/PyQt5[${PYTHON_USEDEP},designer?,opengl?,svg?,webkit?]
		gui? ( dev-python/PyQt5[${PYTHON_USEDEP},gui,widgets] )
		testlib? ( dev-python/PyQt5[${PYTHON_USEDEP},testlib] )
	)
	pyside? (
		dev-python/pyside[${PYTHON_USEDEP},designer?,opengl?,svg?,webkit?]
		gui? ( dev-python/pyside[${PYTHON_USEDEP},X] )
		testlib? ( dev-python/pyside[${PYTHON_USEDEP},X] )
	)
"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
	default

	if ! use pyqt4; then
		sed -i -e "s/from PyQt4.Qt import/raise ImportError #/" qtpy/__init__.py || die
	fi

	if ! use pyqt5; then
		sed -i -e "s/from PyQt5.Qt import/raise ImportError #/" qtpy/__init__.py || die
	fi

	if ! use pyside; then
		sed -i -e "s/from PySide import/raise ImportError #/" qtpy/__init__.py || die
		sed -i -e "s/from PySide2 import/raise ImportError #/" qtpy/__init__.py || die
	fi
}
