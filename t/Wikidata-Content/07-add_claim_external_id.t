use strict;
use warnings;

use Test::More 'tests' => 6;
use Test::NoWarnings;
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
my $ret = $obj->add_claim_external_id({'P214' => '120062731'});
is($ret, undef, 'Add claim.');
my ($claim) = $obj->claims;
is($claim->entity, 'Q42', 'Entity name.');
is($claim->snak->datatype, 'external-id', 'Claim datatype.');
is($claim->snak->property, 'P214', 'Claim property.');
is($claim->snak->datavalue->value, '120062731', 'Get value.');
