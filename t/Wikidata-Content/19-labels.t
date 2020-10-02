use strict;
use warnings;

use Test::More 'tests' => 3;
use Test::NoWarnings;
use Unicode::UTF8 qw(decode_utf8);
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
my @labels = $obj->labels;
is_deeply(\@labels, [], 'Get blank labels.');

# Test.
$obj->add_labels({'cs' => decode_utf8('Příklad'), 'en' => 'Example'});
@labels = $obj->labels;
is(@labels, 2, 'Check number of labels.');
