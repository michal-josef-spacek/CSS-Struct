package CSS::Structure;

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

CSS::Structure - Structure oriented CSS manipulation.

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

=head1 SEE ALSO

L<CSS::Structure::Output::Core>,
L<CSS::Structure::Output::Raw>,
L<CSS::Structure::Output::Indent>,
L<CSS::Structure::Utils>.

=head1 AUTHOR

Michal Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

 © 2007-2020 Michal Špaček
 BSD 2-Clause License

=head1 VERSION

0.01

=cut
