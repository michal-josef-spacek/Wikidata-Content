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
my @descriptions = $obj->descriptions;
is_deeply(\@descriptions, [], 'Get blank descriptions.');

# Test.
$obj->add_descriptions({'cs' => decode_utf8('Příklad'), 'en' => 'Example'});
@descriptions = $obj->descriptions;
is(@descriptions, 2, 'Check number of descriptions.');
