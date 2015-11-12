#!/usr/bin/perl -w

use strict;
use warnings;
use File::Find;
use File::Basename;


my $GRMDIR='/usr/share/polygen';

my %langmap = (
	it => "ita",
	en => "eng",
	fr => "fra"
);

# Get the preferred polygen language directory from the current locale
sub getlang ()
{
	my $lang = $ENV{LC_MESSAGES};
	$lang = $ENV{LANG} if not $lang;
	$lang =~ s/_.+$//;
	return "eng" if not exists $langmap{$lang};
	return $langmap{$lang};
}

# Looks for the best absolute path for the given grammar
sub grmfind ($)
{
	my $name = shift;
	my @cand = ( $name, "$name.grm" );
	my $l = getlang();
	if (defined $l)
	{
		push @cand, "$GRMDIR/$l/$name";
		push @cand, "$GRMDIR/$l/$name.grm";
	}

	# First try the parameter by itself
	for my $pn (@cand)
	{
		return $pn if -e $pn;
	}

	my @dirs;
	find({wanted => sub {
			push @dirs, $File::Find::name if -d $File::Find::name;
		},
		no_chdir => 1,
	}, '/usr/share/polygen');

	for my $d (@dirs)
	{
		return "$d/$name" if -e "$d/$name";
		return "$d/$name.grm" if -e "$d/$name.grm";
	}
	return undef;
}

my $scriptname = basename($0);

if ($scriptname eq 'polyfind')
{
	if (@ARGV) {
		print grmfind($ARGV[0]), "\n";
	} else {
		print STDERR "Usage: $scriptname grammar\n";
	}
}
else
{
	if (@ARGV) {
		my $grm = grmfind($ARGV[$#ARGV]);
		if (not defined $grm)
		{
			print STDERR $ARGV[$#ARGV], ": grammar not found\n";
			exit 1;
		}
		exec 'polygen', $grm

	} else {
		exec 'polygen';
	}
}

exit 0;
