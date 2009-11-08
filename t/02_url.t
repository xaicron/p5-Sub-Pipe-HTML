use strict;
use warnings;
use utf8;
use Test::Base;

plan tests => 1 * blocks;

use Sub::Pipe::HTML;

filters {
	i => [qw/chomp _uri/],
	e => [qw/chomp/],
};

sub _uri {
	my $in = shift;
	return $in | uri;
}

run_is;

__DATA__
=== test 1
--- i
hogehoge
--- e
hogehoge

=== test 2
--- i
[ ]
--- e
%5B%20%5D

=== test 3
--- i
あいうえお
--- e
%E3%81%82%E3%81%84%E3%81%86%E3%81%88%E3%81%8A
