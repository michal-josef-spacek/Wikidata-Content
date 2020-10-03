use strict;
use warnings;

use Test::More 'tests' => 3;
use Test::NoWarnings;
use Unicode::UTF8 qw(decode_utf8);
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
my @aliases = $obj->aliases;
is_deeply(\@aliases, [], 'Get blank aliases.');

# Test.
$obj->add_aliases({
	'cs' => [
		decode_utf8('Alias č. 1'),
		decode_utf8('Alias č. 2'),
	],
	'en' => [
		'Example no. 1',
		'Example no. 2',
	],
});
@aliases = $obj->aliases;
is(@aliases, 4, 'Check number of aliases.');
