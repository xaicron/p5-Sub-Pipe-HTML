use strict;
use warnings;
use Test::Base;

plan tests => 1 * blocks;

use Sub::Pipe::HTML;

filters {
	i => [qw/_html/],
};

sub _html {
	my $in = shift;
	return $in | html;
}

run_is;

__DATA__
=== huga
--- i
hogehoge
--- e
hogehoge

=== fuga
--- i
<>
--- e
&lt;&gt;

=== piyo
--- i
&amp;"
--- e
&amp;amp;&quot;
