package Sub::Pipe::HTML;

use strict;
use warnings;
use Sub::Pipe;
use Exporter 'import';

our $VERSION = '0.01';
our @EXPORT = qw/uri html html_line_break replace clickable/;

sub uri {
	joint {
		require URI::Escape;
		URI::Escape::uri_escape_utf8(shift);
	};
}

sub html {
	joint {
		my $str = shift;
		$str =~ s{([&<>"])}{
			'&' . { qw/& amp  < lt > gt " quot/ }->{$1} . ';' ;
		}msgex;
		$str;
	};
}

sub html_line_break {
	joint {
		local $_ = $_[0];
		s{\r*\n}{<br />}g;
		$_;
	};
}

sub clickable {
	my $config = $_[0] || {};
	joint {
		require URI::Find;
		my $str = shift;
		my $finder = URI::Find->new(
			sub {
				my ($uri, $orig_uri) = @_;
				my $target = $config->{target} ? qq( target="$config->{target}") : '';
				my $rel    = $config->{rel}    ? qq( rel="$config->{rel}") : '';
				return qq(<a href="$uri"$target$rel>$orig_uri</a>);
			},
		);
		$finder->find(\$str);
		return $str;
	};
}

sub replace {
	my ( $regexp, $replace ) = @_;
	joint {
		my $str = shift;
		$str =~ s{$regexp}{$replace}g;
		$str;
	};
}

1;
__END__

=head1 NAME

Sub::Pipe::HTML - chain subs HTML methods

=head1 SYNOPSIS

  use Sub::Pipe::HTML;
  
  print "<pre>" | html;
  print "Perl & Me" | uri;
  print "PHP" | replace( 'HP', 'erl' );
  print "Rock\nRoll" | html_line_break | uri;
  print "http://example.com" | clickable;

=head1 DESCRIPTION

Sub::Pipe::HTML is

=head1 EXPORT

C<html>, C<html_line_break>, C<uri>, C<replace>, C<clickable>

=head1 AUTHOR

Yuji Shimada E<lt>xaicron {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
