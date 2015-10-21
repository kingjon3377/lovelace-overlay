#!/usr/bin/perl -w

# Generate the polygen-data manpage, scanning the grammar files whose name is
# supplied on stdin.
#
# Copyright: (C) 2005 Enrico Zini <enrico@debian.org>
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# On Debian systems, the complete text of the GNU General Public License can be
# found in /usr/share/common-licenses/GPL file.

use strict;
use warnings;
use File::Basename;

our $POLYGEN = ($ENV{POLYGEN} or "polygen");

sub extract_metadata ($)
{
	my ($file) = @_;
	my %res;

	# Read the grammar
	open(IN, "$POLYGEN -info '$file'|") or die "Cannot run $POLYGEN -info '$file': $!";
	my $lastfield;
	while (<IN>)
	{
		chop;
		if (/^([^:]+):\s*(.+?)\s*$/)
		{
			$res{$1} = $2;
			$lastfield = $1;
		} elsif (/^\s*$/) {
		} else {
			if (defined $lastfield)
			{
				$res{$lastfield} .= "\n".$_;
			} else {
				die "UNPARSED in $file: $_\n";
			}
		}
	}
	close(IN);

	return \%res;
}

print q{
.TH POLYGEN-DATA 6
.SH NAME
polygen-data \- assorted polygen grammars
.SH SYNOPSIS
.B polygen \fIgrammar\fP
.SH "DESCRIPTION"
All of these grammars output all sort of strange and out\-of\-control things.
No personal, racial, societal slurs are intended.  For amusement only.
.P
You can find out more information about a grammar with the command
.B polygen \-info \fIgrammar\fP
};

my %langnames = (
	fra => "French",
	ita => "Italian",
	eng => "English"
);

my %langs;

while (my $file = <>)
{
	chop($file);

	my ($name, $path) = fileparse($file);

	$path =~ s/(.+\/)?(.+)\/$/$2/;

	my $md = extract_metadata($file);
	$md->{filename} = $name;

	push(@{$langs{$path}}, $md);

}

for my $lang ('eng', 'ita', 'fra')
{
	print ".SS ", $langnames{$lang}, " grammars\n";

	for my $md (@{$langs{$lang}})
	{
		print ".IP ", $md->{filename}, "\n";
		print $md->{title}, "\n";
	}
}

print q{
.SH "SEE ALSO"
polygen(1)
.SH AUTHORS
Polygen has been written by Manta.
.P
These grammars have been written by various contributors.  Run \fBpolygen
\-info\fP \fIgrammar\fP for information about their authors.
};
