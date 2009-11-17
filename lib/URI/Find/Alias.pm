package URI::Find::Alias;

use strict;
use warnings;
use base qw( URI::Find::UTF8 );

our $VERIOSN = '0.01';

use base qw( URI::Find::UTF8 );

sub uri_re {
	@_ == 1 || __PACKAGE__->badinvo;
	my $self = shift;
	my $x = sprintf '%s:/{0,2}[%s]+/[%s]*%s*|%s',
		$URI::scheme_re,
		'A-Za-z0-9\-\.',         # Domain part ... don't care about IDN yet
		$self->uric_set . '\w#', # \w will have all 'word' characters in UTF8 semantics
		'(?:{[^}]+})',           # {text}
		$self->SUPER::uri_re,    # Make this less priority
	;
	return $x;
}

sub _is_uri {
	@_ == 2 || __PACKAGE__->badinvo;
	
	my($self, $r_uri_cand) = @_;
	my $uri_cand = $$r_uri_cand;
	
	$uri_cand =~ s/{[^}]+}$//;
	
	return $self->SUPER::_is_uri(\$uri_cand);
}

sub _uri_filter {
	my($self, $orig_match) = @_;
	$orig_match = $self->decruft($orig_match);
	
	my $replacement = '';
	if( my $uri = $self->_is_uri(\$orig_match) ) {
		$self->{_uris_found}++;
		$orig_match =~ s/{([^}]+)}$//;
		$replacement = $self->{callback}->($uri, $orig_match, $1);
	}
	else {
		$replacement = $orig_match;
	}
	
	return $self->recruft($replacement);
}

1;
__END__
=head1 NAME

URI::Find::Alias - Finds URI from arbitrary text, and sttuf alias support.

=head1 SYNOPSIS

  use utf8;
  use URI::Find::Alias;
  
  $text = << 'TEXT'
  Japanese Wikipedia home page is http://ja.wikipedia.org/wiki/メインページ{alias name}
  TEXT

=head1 DESCRIPTION

URI::Find::Alias is L<URI::Find::UTF8> base.

=head1 AUTHOR

Yuji Shimada E<lt>xaicron {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
