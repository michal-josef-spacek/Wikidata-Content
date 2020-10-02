use strict;
use warnings;

use Test::More 'tests' => 3;
use Test::NoWarnings;
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new;
is($obj->entity, undef, 'No entity.');

# Test.
$obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
is($obj->entity, 'Q42', 'Existing entity.');
