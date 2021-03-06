#!/usr/bin/env perl

use strict;
use warnings;

use CSS::Struct::Output::Raw;

my $css = CSS::Struct::Output::Raw->new(
        'output_handler' => \*STDOUT,
);

$css->put(['c', 'comment']);
$css->put(['a', '@charset', 'utf-8']);
$css->put(['s', 'selector#id']);
$css->put(['s', 'div div']);
$css->put(['s', '.class']);
$css->put(['d', 'weight', '100px']);
$css->put(['d', 'font-size', '10em']);
$css->put(['e']);
$css->put(['r', "\n"]);
$css->flush;

# Output:
# /*comment*/@charset "utf-8";selector#id,div div,.class{weight:100px;font-size:10em;}