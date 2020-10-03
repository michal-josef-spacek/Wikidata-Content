use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Test::More 'tests' => 18;
use Test::NoWarnings;
use Wikidata::Content;
use Wikidata::Datatype::Sitelink;
use Wikidata::Datatype::Snak;
use Wikidata::Datatype::Statement;
use Wikidata::Datatype::Value::Monolingual;
use Wikidata::Datatype::Value::String;

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

# Test.
eval {
	Wikidata::Content->new(
		'claims' => 'foo',
	);
};
is($EVAL_ERROR, "Parameter 'claims' must be a array.\n",
	"Parameter 'claims' has bad value - scalar.");
clean();

# Test.
eval {
	Wikidata::Content->new(
		'claims' => ['foo'],
	);
};
is($EVAL_ERROR,
	"Parameter 'claims' must contain 'Wikidata::Datatype::Statement' objects only.\n",
	"Parameter 'claims' has bad value - array with string.");
clean();

# Test.
$obj = Wikidata::Content->new(
	'claims' => [
		Wikidata::Datatype::Statement->new(
			'entity' => 'Q42',
			'snak' => Wikidata::Datatype::Snak->new(
				'datatype' => 'string',
				'datavalue' => Wikidata::Datatype::Value::String->new(
					'value' => 'foo',
				),
				'property' => 'P142',
			),
		),
	],
);
isa_ok($obj, 'Wikidata::Content');

# Test.
eval {
	Wikidata::Content->new(
		'descriptions' => 'foo',
	);
};
is($EVAL_ERROR, "Parameter 'descriptions' must be a array.\n",
	"Parameter 'descriptions' has bad value - scalar.");
clean();

# Test.
eval {
	Wikidata::Content->new(
		'descriptions' => ['foo'],
	);
};
is($EVAL_ERROR,
	"Parameter 'descriptions' must contain 'Wikidata::Datatype::Value::Monolingual' objects only.\n",
	"Parameter 'descriptions' has bad value - array with string.");
clean();

# Test.
$obj = Wikidata::Content->new(
	'descriptions' => [
		Wikidata::Datatype::Value::Monolingual->new('value' => 'text'),
	],
);
isa_ok($obj, 'Wikidata::Content');

# Test.
eval {
	Wikidata::Content->new(
		'labels' => 'foo',
	);
};
is($EVAL_ERROR, "Parameter 'labels' must be a array.\n",
	"Parameter 'labels' has bad value - scalar.");
clean();

# Test.
eval {
	Wikidata::Content->new(
		'labels' => ['foo'],
	);
};
is($EVAL_ERROR,
	"Parameter 'labels' must contain 'Wikidata::Datatype::Value::Monolingual' objects only.\n",
	"Parameter 'labels' has bad value - array with string.");
clean();

# Test.
$obj = Wikidata::Content->new(
	'labels' => [
		Wikidata::Datatype::Value::Monolingual->new('value' => 'text'),
	],
);
isa_ok($obj, 'Wikidata::Content');

# Test.
eval {
	Wikidata::Content->new(
		'sitelinks' => 'foo',
	);
};
is($EVAL_ERROR, "Parameter 'sitelinks' must be a array.\n",
	"Parameter 'sitelinks' has bad value - scalar.");
clean();

# Test.
eval {
	Wikidata::Content->new(
		'sitelinks' => ['foo'],
	);
};
is($EVAL_ERROR,
	"Parameter 'sitelinks' must contain 'Wikidata::Datatype::Sitelink' objects only.\n",
	"Parameter 'sitelinks' has bad value - array with string.");
clean();

# Test.
$obj = Wikidata::Content->new(
	'sitelinks' => [
		Wikidata::Datatype::Sitelink->new(
			'site' => 'cswiki',
			'title' => 'Main page',
		),
	],
);
isa_ok($obj, 'Wikidata::Content');
