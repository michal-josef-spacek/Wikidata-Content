use strict;
use warnings;

use Test::More 'tests' => 8;
use Test::NoWarnings;
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
my $ret = $obj->add_claim_item({'P31' => 'Q5'});
is($ret, undef, 'Add claim.');
my ($claim) = $obj->claims;
is($claim->entity, 'Q42', 'Entity name.');
is($claim->snak->datatype, 'wikibase-item', 'Claim datatype.');
is($claim->snak->property, 'P31', 'Claim property.');
is($claim->snak->datavalue->value, 'Q5', 'Get value.');

# Test.
$obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
$ret = $obj->add_claim_item({'P31' => ['Q5', 'Q6']});
is($ret, undef, 'Add claim.');
my @claims = $obj->claims;
is(@claims, 2, 'Get two claims.');
