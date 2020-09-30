use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Test::More 'tests' => 3;
use Test::NoWarnings;
use Wikidata::Content;

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

# TODO claims
