use strict;
use warnings;
use utf8;
use Test::Base;

plan tests => 1 * blocks;

use Sub::Pipe::HTML;

filters {
	i => [qw/yaml _clickable/],
	e => [qw/chomp/],
};

sub _clickable {
	my $in = shift;
	return $in->{href} | clickable({text => $in->{text}, target => $in->{target}, rel => $in->{rel}});
}

run_is;

__DATA__
=== test 1
--- i
href: hogehoge
--- e
hogehoge

=== test 2
--- i
href: http://www.example.com/
--- e
<a href="http://www.example.com/">http://www.example.com/</a>

=== test 3
--- i
href: http://www.example.com/
text: example
--- e
<a href="http://www.example.com/">example</a>

=== test 4
--- i
href: http://www.example.com/
text: 0
--- e
<a href="http://www.example.com/">0</a>

=== test 5
--- i
href: http://www.example.com/
text: example
target: _blank
--- e
<a href="http://www.example.com/" target="_blank">example</a>

=== test 6
--- i
href: http://www.example.com/
text: example
target: _blank
rel: tag
--- e
<a href="http://www.example.com/" target="_blank" rel="tag">example</a>

=== test utf8
--- i
href: 'http://www.example.com/日本語ページ'
--- e
<a href="http://www.example.com/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%9A%E3%83%BC%E3%82%B8">http://www.example.com/日本語ページ</a>

=== test alias
--- i
href: 'http://www.example.com/{example}'
--- e
<a href="http://www.example.com/">example</a>

