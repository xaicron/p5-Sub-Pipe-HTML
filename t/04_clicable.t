use strict;
use warnings;
use utf8;
use Test::Base;

plan tests => 1 * blocks;

use Sub::Pipe::HTML;

filters {
	i => [qw/chomp _clickable/],
	e => [qw/chomp/],
};

sub _clickable {
	my $in = shift;
	return $in | clickable;
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
http://www.example.com
--- e
<a href="http://www.example.com/">http://www.example.com</a>
