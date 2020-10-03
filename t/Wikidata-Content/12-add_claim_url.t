use strict;
use warnings;

use Test::More 'tests' => 6;
use Test::NoWarnings;
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
my $ret = $obj->add_claim_url({'P856' => 'https://skim.cz'});
is($ret, undef, 'Add claim.');
my ($claim) = $obj->claims;
is($claim->entity, 'Q42', 'Entity name.');
is($claim->snak->datatype, 'url', 'Claim datatype.');
is($claim->snak->property, 'P856', 'Claim property.');
is($claim->snak->datavalue->value, 'https://skim.cz', 'Get value.');
