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

	# Comment after selector.
	$self->{'comment_after_selector'} = 0;

	# Indent string.
	$self->{'next_indent'} = "\t";

	return;
}

#------------------------------------------------------------------------------
sub _flush_tmp {
#------------------------------------------------------------------------------
# Flush $self->{'tmp_code'}.

	my $self = shift;
	if (@{$self->{'tmp_code'}}) {
		$self->{'indent'}->add;
		my @comment;
		if ($self->{'comment_after_selector'}) {
			@comment = splice @{$self->{'tmp_code'}},
				-$self->{'comment_after_selector'};
			pop @comment;
			foreach my $com (@comment) {
				if ($com ne $EMPTY_STR && $com ne "\n") {
					$com = $self->{'indent'}->get.$com;
				}
			}
		} else {
			pop @{$self->{'tmp_code'}};
		}
		pop @{$self->{'tmp_code'}};
		push @{$self->{'flush_code'}}, 
			(join $EMPTY_STR, @{$self->{'tmp_code'}}).' {'.
			(join $EMPTY_STR, @comment);
		$self->{'tmp_code'} = [];
		$self->{'processed'} = 1;
	}
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
	if (! $self->{'skip_comments'}) {
		push @comments, $SPACE.$self->{'comment_delimeters'}->[1];
		unshift @comments, $self->{'comment_delimeters'}->[0].$SPACE;
		if ($self->{'processed'}) {
			push @{$self->{'flush_code'}}, $EMPTY_STR;
		}
		my $comment = (join $EMPTY_STR, @comments);
		if (@{$self->{'tmp_code'}}) {
			my $sep = $EMPTY_STR;
			if ($self->{'comment_after_selector'} == 0) {
				$sep = $self->{'output_sep'};
				pop @{$self->{'tmp_code'}};
			}
			push @{$self->{'tmp_code'}}, ($sep) x 2, $comment, 
				$self->{'output_sep'};
			$self->{'comment_after_selector'} += 4;
		} else {
			push @{$self->{'flush_code'}}, 
				$self->{'indent'}->get.$comment;
		}
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
	push @{$self->{'tmp_code'}}, $selector, ',', ' ';
	$self->{'comment_after_selector'} = 0;
	$self->{'open_selector'} = 1;
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
