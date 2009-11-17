use strict;
use warnings;
use utf8;
use Test::Base;
use URI::Find::Alias;

filters { raw => 'chomp', uri => 'chomp', alias => 'chomp' };

plan tests => 3 * blocks;

run {
    my $block = shift;

    my $f = URI::Find::Alias->new(
        sub {
            my($uri, $orig, $alias) = @_;
            is $uri->as_string, $block->uri, "$uri";
            is $orig, $block->raw, "raw path";
            is $alias, $block->alias, "alias";
        },
    );
    $f->find(\$block->input);
}

__DATA__

===
--- input
アンサイクロペディアのホームページはhttp://ja.uncyclopedia.info/wiki/メインページ{アンサイクロペディア} foo bar
--- raw
http://ja.uncyclopedia.info/wiki/メインページ
--- uri
http://ja.uncyclopedia.info/wiki/%E3%83%A1%E3%82%A4%E3%83%B3%E3%83%9A%E3%83%BC%E3%82%B8
--- alias
アンサイクロペディア

===
--- input
Home page <URL:http://www.google.com{Google}> Google
--- raw
http://www.google.com
--- uri
http://www.google.com/
--- alias
Google
