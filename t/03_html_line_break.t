use strict;
use warnings;
use utf8;
use Test::Base;

plan tests => 1 * blocks;

use Sub::Pipe::HTML;

filters {
	i => [qw/chomp _html_br/],
	e => [qw/chomp/],
};

sub _html_br {
	my $in = shift;
	return $in | html_line_break;
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
hoge
hoge
--- e
hoge<br />hoge
