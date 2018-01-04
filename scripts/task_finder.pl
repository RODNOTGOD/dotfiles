#!/usr/bin/env perl

use strict;
use warnings;
use Getopt::Long;
use File::Find;
use File::Basename;
use Term::ANSIColor;

my $help;
my $path;
my $sorted;
my $maxdepth;
my $case_sensitive;
my $tag = "TODO|FIXME|XXX";
my @sortedTasks;
my @sortedNoDate;

GetOptions (
	'tag|t=s'      => sub { $tag = join('|', split(/(?<!\\)[\s\|]+/, $_[1])) },
	'add|a=s'      => sub { $tag = join('|', split(/(?<!\\)[\s\|]+/, $_[1] . " " .$tag))},
	'help|h'       => \$help,
	'maxdepth|d=i' => \$maxdepth,
	'sorted|s'     => \$sorted,
	'case|c'       => \$case_sensitive
);

usage($0) if defined $help;

if (not defined $case_sensitive) {
	$case_sensitive = "i";
} else {
	undef $case_sensitive;
}

$tag =~ s/\\(?=\s)//g;
$tag = join '|', $tag;

die "Missing path to search" if $#ARGV < 0;

while (@ARGV) {
	$path = shift @ARGV;
	find (\&findTask, $path);
	printTask() if defined $sorted;
}


sub findTask {
	my $filename = $File::Find::name;

	my $depth = File::Spec->splitdir($filename);
	defined $maxdepth && $depth - 1 > $maxdepth and $File::Find::prune = 1;
	open(my $file, "<", $_) or print "$!";
	while (<$file>) {
		no warnings 'uninitialized';
		chomp;
		if (my ($catagory, $message, $info) = /(?$case_sensitive:\b($tag)\b.*:\s*([\w\d\s\p{Punct}`=]*)(<.*>)?)/ and -T $file) {
			if ($info) {
				$info =~ s/[<>]//g;
				my ($date, $author) = split /,\s*/, $info;
				(defined $sorted) ? push @sortedTasks, $filename . ":$.:$date:$author:$catagory:$message\n" :
									print "$filename:$.:$date:$author:$catagory:$message\n";
			} else {
				(defined $sorted) ? push @sortedNoDate, $filename . ":$.:$catagory:$message\n" :
									print "$filename:$.:$catagory:$message\n";
			}
		}
	}
	close $file;
}

sub printTask {
	for (sort { (split ':', $a)[2] cmp (split ':', $b)[2] } @sortedTasks) {
		print;
	}
	foreach my $task (@sortedNoDate) {
		print $task;
	}
}


sub usage {
	print "Usage: " . basename($0) . "\n";
	print "Scans for syntax `(tag): ... <date, author>`\n";
	print "    --help       -h         print this dialogue\n";
	print "    --tag        -t         set what tags to search for. (default \"TODO|FIXME|XXX\")\n";
	print "    --add        -a         add a set of tags to current default tags\n";
	print "    --case       -c         set case sensitive\n";
	print "    --maxdepth   -d         set max depth of search for files\n";
	print "    --sort       -s         sort date for strings following syntax `(TODO: important info <date, author>)`\n";
	exit 0;
}
