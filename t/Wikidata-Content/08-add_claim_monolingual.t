use strict;
use warnings;

use Test::More 'tests' => 13;
use Test::NoWarnings;
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
my $ret = $obj->add_claim_monolingual({'P1476' => {'language' => 'cs', 'value' => 'foo'}});
is($ret, undef, 'Add claim.');
my ($claim) = $obj->claims;
is($claim->entity, 'Q42', 'Entity name.');
is($claim->snak->datatype, 'monolingualtext', 'Claim datatype.');
is($claim->snak->property, 'P1476', 'Claim property.');
is($claim->snak->datavalue->value, 'foo', 'Get value.');
is($claim->snak->datavalue->language, 'cs', 'Get value language.');

# Test.
$obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
$ret = $obj->add_claim_monolingual({'P1476' => 'foo'});
is($ret, undef, 'Add claim.');
($claim) = $obj->claims;
is($claim->entity, 'Q42', 'Entity name.');
is($claim->snak->datatype, 'monolingualtext', 'Claim datatype.');
is($claim->snak->property, 'P1476', 'Claim property.');
is($claim->snak->datavalue->value, 'foo', 'Get value.');
is($claim->snak->datavalue->language, 'en', 'Get value language.');
