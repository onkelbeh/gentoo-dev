# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit vim-plugin python-single-r1

DESCRIPTION="vim plugin: A set of menus/shortcuts to work with Python files"
HOMEPAGE="https://www.vim.org/scripts/script.php?script_id=30"

LICENSE="vim"
KEYWORDS="~alpha amd64 ppc sparc x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}"
