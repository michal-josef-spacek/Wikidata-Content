use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Test::More 'tests' => 6;
use Test::NoWarnings;
use Wikidata::Content;
use Wikidata::Datatype::Value::Monolingual;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
isa_ok($obj, 'Wikidata::Content');

# Test.
eval {
	Wikidata::Content->new(
		'entity' => 'q42',
	);
};
is($EVAL_ERROR,
	"Parameter 'entity' must contain string with Q on begin and numbers.\n",
	"Bad 'entity' parameter value.");
clean();

# Test.
eval {
	Wikidata::Content->new(
		'aliases' => {},
	);
};
is($EVAL_ERROR,
	"Parameter 'aliases' must be a reference to array.\n",
	"Parameter 'aliases' is bad - reference to hash.");
clean();

# Test.
eval {
	Wikidata::Content->new(
		'aliases' => ['foo'],
	);
};
is($EVAL_ERROR,
	"Parameter 'alias' must contain 'Wikidata::Datatype::Value::Monolingual' objects only.\n",
	"Parameter 'aliases' has bad value - scalar.");
clean();

# Test.
$obj = Wikidata::Content->new(
	'aliases' => [
		Wikidata::Datatype::Value::Monolingual->new('value' => 'text'),
	],
);
isa_ok($obj, 'Wikidata::Content');

# TODO claims
