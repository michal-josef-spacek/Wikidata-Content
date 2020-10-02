use strict;
use warnings;

use Test::More 'tests' => 6;
use Test::NoWarnings;
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
my $ret = $obj->add_claim_time({'P569' => '+2018-09-29T00:00:00Z'});
is($ret, undef, 'Add claim.');
my ($claim) = $obj->claims;
is($claim->entity, 'Q42', 'Entity name.');
is($claim->snak->datatype, 'time', 'Claim datatype.');
is($claim->snak->property, 'P569', 'Claim property.');
is($claim->snak->datavalue->value, '+2018-09-29T00:00:00Z', 'Get value.');
