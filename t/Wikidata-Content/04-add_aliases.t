use strict;
use warnings;

use Test::More 'tests' => 2;
use Test::NoWarnings;
use Unicode::UTF8 qw(decode_utf8);
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
my $ret = $obj->add_aliases({
	'cs' => [
		decode_utf8('Alias č. 1'),
		decode_utf8('Alias č. 2'),
	],
	'en' => [
		'Example no. 1',
		'Example no. 2',
	],
});
is($ret, undef, 'Add aliases.');
