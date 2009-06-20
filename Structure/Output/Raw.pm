#------------------------------------------------------------------------------
package CSS::Structure::Output::Raw;
#------------------------------------------------------------------------------

# Pragmas.
use base qw(CSS::Structure::Output::Core);
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);
use List::MoreUtils qw(none);
use Readonly;

# Constants.
Readonly::Scalar my $EMPTY_STR => q{};

# Version.
our $VERSION = 0.01;

#------------------------------------------------------------------------------
# Private methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _flush_tmp {
#------------------------------------------------------------------------------
# Flush $self->{'tmp_code'}.

	my $self = shift;
	if (@{$self->{'tmp_code'}}) {
		$self->{'flush_code'} .= (join ',', @{$self->{'tmp_code'}}).
			'{';
		$self->{'tmp_code'} = [];
	}
	return;
}

#------------------------------------------------------------------------------
sub _put_at_rules {
#------------------------------------------------------------------------------
# At-rules.

	my ($self, $at_rule, $file) = @_;
	$self->{'flush_code'} .= $at_rule;
	$self->{'flush_code'} .= ' "'.$file.'";';
	return;
}

#------------------------------------------------------------------------------
sub _put_comment {
#------------------------------------------------------------------------------
# Comment.

	my ($self, @comments) = @_;
	if (! $self->{'skip_comments'}) {
		push @comments, $self->{'comment_delimeters'}->[1];
		unshift @comments, $self->{'comment_delimeters'}->[0];
		$self->{'flush_code'} .= join $EMPTY_STR, @comments;
	}
	return;
}

#------------------------------------------------------------------------------
sub _put_definition {
#------------------------------------------------------------------------------
# Definition.

	my ($self, $key, $value) = @_;
	$self->_check_opened_selector;
	$self->_flush_tmp;
	$self->{'flush_code'} .= $key.':'.$value.';';
	return;
}

#------------------------------------------------------------------------------
sub _put_end_of_selector {
#------------------------------------------------------------------------------
# End of selector.

	my $self = shift;
	$self->_check_opened_selector;
	$self->_flush_tmp;
	$self->{'flush_code'} .= '}';
	$self->{'open_selector'} = 0;
	return;
}

#------------------------------------------------------------------------------
sub _put_instruction {
#------------------------------------------------------------------------------
# Instruction.

	my ($self, $target, $code) = @_;
	$self->_put_comment($target, $code);
	return;
}

#------------------------------------------------------------------------------
sub _put_raw {
#------------------------------------------------------------------------------
# Raw data.

	my ($self, @raw_data) = @_;

	# To flush code.
	$self->{'flush_code'} .= join $EMPTY_STR, @raw_data;

	return;
}

#------------------------------------------------------------------------------
sub _put_selector {
#------------------------------------------------------------------------------
# Selectors.

	my ($self, $selector) = @_;
	push @{$self->{'tmp_code'}}, $selector;
	$self->{'open_selector'} = 1;
	return;
}

#------------------------------------------------------------------------------
sub _reset_flush_code {
#------------------------------------------------------------------------------
# Reset flush code.

	my $self = shift;
	$self->{'flush_code'} = $EMPTY_STR;
	reset;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

 CSS::Structure::Output::Raw - Raw printing 'CSS::Structure' structure to css code.

=head1 SYNOPSIS

 use CSS::Structure::Output::Raw;
 my $css = CSS::Structure::Output::Raw->new(
         'output_handler' => \*STDOUT,
 );
 $css->put(
         ['s', 'blam'],
         ['d', 'weight', '100px'],
         ['e'],
 );
 $css->flush;
 $css->reset;

=head1 METHODS

=over 8

=item B<new(%parameters)>

 Constructor.

=over 8

=item * B<comment_delimeters>

 TODO

=item * B<output_handler>

 Handler for print output strings.
 Default is undef.

=item * B<skip_bad_tags>

 TODO

=back

=item B<flush()>

 TODO

=item B<put()>

 TODO

=item B<reset()>

 TODO

=back

=head1 ERRORS

TODO

=head1 DEPENDENCIES

L<Error::Simple::Multiple(3pm)>,
L<List::MoreUtils(3pm)>,
L<Readonly(3pm)>.

=head1 SEE ALSO

L<CSS::Structure(3pm)>,
L<CSS::Structure::Output::Core(3pm)>,
L<CSS::Structure::Output::Indent(3pm)>.

=head1 AUTHOR

 Michal Špaček L<tupinek@gmail.com>

=head1 LICENSE AND COPYRIGHT

 BSD license.

=head1 VERSION

 0.01

=cut
