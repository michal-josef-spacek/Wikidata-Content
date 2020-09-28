use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Test::More 'tests' => 3;
use Test::NoWarnings;
use Wikidata::Simple;

# Test.
my $obj = Wikidata::Simple->new(
	'entity' => 'Q42',
);
isa_ok($obj, 'Wikidata::Simple');

# Test.
eval {
	Wikidata::Simple->new(
		'entity' => 'q42',
	);
};
is($EVAL_ERROR,
	"Parameter 'entity' must contain string with Q on begin and numbers.\n",
	"Bad 'entity' parameter value.");
clean();

# TODO claims
