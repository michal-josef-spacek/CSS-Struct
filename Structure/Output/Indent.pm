#------------------------------------------------------------------------------
package CSS::Structure::Output::Indent;
#------------------------------------------------------------------------------

# Pragmas.
use base qw(CSS::Structure::Output::Core);
use strict;
use warnings;

# Modules.
use Indent;
use Readonly;

# Constants.
Readonly::Scalar my $EMPTY_STR => q{};
Readonly::Scalar my $SPACE => q{ };

# Version.
our $VERSION = 0.01;

#------------------------------------------------------------------------------
sub reset {
#------------------------------------------------------------------------------
# Resets internal variables.

	my $self = shift;

	# Reset internal variables from *::Core.
	$self->SUPER::reset;

	# Any processed selector.
	$self->{'processed'} = 0;

	# Indent object.
	$self->{'indent'} = Indent->new(
		'next_indent' => $self->{'next_indent'},
	);

	return;
}

#------------------------------------------------------------------------------
# Private methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _default_parameters {
#------------------------------------------------------------------------------
# Default parameters.

	my $self = shift;

	# Default parameters from SUPER.
	$self->SUPER::_default_parameters;

	# Indent string.
	$self->{'next_indent'} = "\t";

	return;
}

#------------------------------------------------------------------------------
sub _put_at_rules {
#------------------------------------------------------------------------------
# At-rules.

	my ($self, $at_rule, $file) = @_;
	push @{$self->{'flush_code'}}, $at_rule.' "'.$file.'";';
	$self->{'processed'} = 1;
	return;
}

#------------------------------------------------------------------------------
sub _put_comment {
#------------------------------------------------------------------------------
# Comment.

	my ($self, @comments) = @_;
	$self->_flush_tmp;
	if (! $self->{'skip_comments'}) {
		push @comments, $SPACE.$self->{'comment_delimeters'}->[1];
		unshift @comments, $self->{'comment_delimeters'}->[0].$SPACE;
		if ($self->{'processed'}) {
			push @{$self->{'flush_code'}}, $EMPTY_STR;
		}
		push @{$self->{'flush_code'}}, $self->{'indent'}->get.
			(join $EMPTY_STR, @comments);
		$self->{'processed'} = 0;
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
	push @{$self->{'flush_code'}}, $self->{'indent'}->get.$key.':'.
		$SPACE.$value.';';
	$self->{'processed'} = 1;
	return;
}

#------------------------------------------------------------------------------
sub _put_end_of_selector {
#------------------------------------------------------------------------------
# End of selector.

	my $self = shift;
	$self->_check_opened_selector;
	$self->_flush_tmp;
	$self->{'indent'}->remove;
	push @{$self->{'flush_code'}}, '}';
	$self->{'open_selector'} = 0;
	$self->{'processed'} = 1;
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
	push @{$self->{'flush_code'}}, (join $EMPTY_STR, @raw_data);

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
sub _flush_tmp {
#------------------------------------------------------------------------------
# Flush $self->{'tmp_code'}.

	my $self = shift;
	if (@{$self->{'tmp_code'}}) {
		push @{$self->{'flush_code'}}, 
			(join ', ', @{$self->{'tmp_code'}}).' {';
		$self->{'tmp_code'} = [];
		$self->{'processed'} = 1;
		$self->{'indent'}->add;
	}
	return;
}

#------------------------------------------------------------------------------
sub _reset_flush_code {
#------------------------------------------------------------------------------
# Reset flush code.

	my $self = shift;
	$self->{'flush_code'} = [];
	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

 CSS::Structure::Output::Indent - Indent printing 'CSS::Structure' structure to CSS code.

=head1 SYNOPSIS

 use CSS::Structure::Output::Indent;
 my $css = CSS::Structure::Output::Indent->new(%parameters);
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

=item * B<skip_bad_types>

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

L<Indent(3pm)>,
L<Readonly(3pm)>.

=head1 SEE ALSO

L<CSS::Structure(3pm)>,
L<CSS::Structure::Utils(3pm)>,
L<CSS::Structure::Output::Core(3pm)>.
L<CSS::Structure::Output::Raw(3pm)>.

=head1 AUTHOR

 Michal Špaček L<tupinek@gmail.com>

=head1 LICENSE AND COPYRIGHT

 BSD license.

=head1 VERSION

 0.01

=cut
