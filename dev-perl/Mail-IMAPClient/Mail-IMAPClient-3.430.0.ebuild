# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=PLOBBES
DIST_VERSION=3.43
DIST_EXAMPLES=("examples/*")
inherit perl-module

DESCRIPTION="IMAP client module for Perl"

SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ppc ppc64 ~riscv ~s390 sparc x86"
IUSE="test ntlm md5 ssl zlib"

PATCHES=(
	"${FILESDIR}/${DIST_VERSION}-makefilepl.patch"
)

PERL_RM_FILES=(
	"t/quota.t" # Requires imap server config in test.txt
	"t/basic.t"
	"t/pod.t"   # Bad author test
)

# IO::File, IO::Select, IO::Socket, IO::Socket::INET -> perl-IO
# Digest::HMAC_MD5 -> Digest-HMAC
RDEPEND="
	virtual/perl-Carp
	virtual/perl-File-Temp
	>=virtual/perl-IO-1.260.0
	virtual/perl-Scalar-List-Utils
	virtual/perl-MIME-Base64
	>=dev-perl/Parse-RecDescent-1.940.0
	ntlm? ( dev-perl/Authen-NTLM )
	md5? (
		dev-perl/Authen-SASL
		dev-perl/Digest-HMAC
		virtual/perl-Digest-MD5
	)
	ssl? ( dev-perl/IO-Socket-SSL )
	zlib? ( virtual/perl-IO-Compress )
"
BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		virtual/perl-Test-Simple
	)
"
