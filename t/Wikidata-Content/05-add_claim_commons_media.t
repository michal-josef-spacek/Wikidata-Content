use strict;
use warnings;

use Test::More 'tests' => 6;
use Test::NoWarnings;
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
my $ret = $obj->add_claim_commons_media({'P185' => 'Michal Josef Špaček - self photo.jpg'});
is($ret, undef, 'Add claim.');
my ($claim) = $obj->claims;
is($claim->entity, 'Q42', 'Entity name.');
is($claim->snak->datatype, 'commonsMedia', 'Claim datatype.');
is($claim->snak->property, 'P185', 'Claim property.');
is($claim->snak->datavalue->value, 'Michal Josef Špaček - self photo.jpg', 'Claim value.');
