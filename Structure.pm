#------------------------------------------------------------------------------
package CSS::Structure;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Version.
our $VERSION = 0.01;

1;

__END__

=pod

=encoding utf8

=head1 NAME

 CSS::Structure - Overview about CSS::Structure classes.

=head1 STRUCTURE

 Perl structure:

 Reference to array.
 [type, data]

 Types:
 a - At-rules.
 c - Comment.
 d - Definition.
 e - End of selector.
 i - Instruction.
 r - Raw section.
 s - Selector.

 Data:
 a - $at_rule, $file
 c - @comment
 d - $key, $value
 e - No argument.
 i - $target, $code
 r - @raw_data
 s - $selector

=head1 DEPENDENCIES

 None.

=head1 SEE ALSO

L<CSS::Structure::Output::Core(3pm)>,
L<CSS::Structure::Output::Raw(3pm)>,
L<CSS::Structure::Output::Indent(3pm)>,
L<CSS::Structure::Utils(3pm)>.

=head1 AUTHOR

 Michal Špaček L<tupinek@gmail.com>

=head1 LICENSE AND COPYRIGHT

 BSD license.

=head1 VERSION

 0.01

=cut
