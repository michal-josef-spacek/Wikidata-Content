use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Test::More 'tests' => 9;
use Test::NoWarnings;
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
my $ret = $obj->add_claim('commonsMedia', {
	'P185' => 'Michal Josef Špaček - self photo.jpg',
});
is($ret, undef, 'Add claim.');
my ($claim) = $obj->claims;
is($claim->entity, 'Q42', 'Entity name.');
is($claim->snak->datatype, 'commonsMedia', 'Claim datatype.');
is($claim->snak->property, 'P185', 'Claim property.');
is($claim->snak->datavalue->value, 'Michal Josef Špaček - self photo.jpg', 'Claim value.');

# Test.
eval {
	$obj->add_claim('commonsMedia', {
		'P185' => 'Michal Josef Špaček - self photo.jpg',
		'P184' => 'Michal Josef Špaček - self photo.jpg',
	});
};
is($EVAL_ERROR, "Multiple properties.\n", 'Multiple properties.');
clean();

# Test.
eval {
	$obj->add_claim('commonsMedia', {});
};
is($EVAL_ERROR, "No property.\n", 'No property.');
clean();

# Test.
$obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
$ret = $obj->add_claim('commonsMedia', {
	'P185' => 'Michal Josef Špaček - self photo.jpg',
	'foo' => 'bar',
});
is($ret, undef, 'Add claim.');
