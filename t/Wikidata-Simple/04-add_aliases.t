use strict;
use warnings;

use Test::More 'tests' => 2;
use Test::NoWarnings;
use Unicode::UTF8 qw(decode_utf8);
use Wikidata::Simple;

# Test.
my $obj = Wikidata::Simple->new(
	'entity' => 'Q42',
);
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
my $ret_hr = $obj->serialize;
is_deeply(
	$ret_hr,
	{
		'aliases' => {
			'cs' => [
				{
					'language' => 'cs',
					'value' => decode_utf8('Alias č. 1'),
				}, {
					'language' => 'cs',
					'value' => decode_utf8('Alias č. 2'),
				},
			],
			'en' => [
				{
					'language' => 'en',
					'value' => 'Example no. 1',
				}, {
					'language' => 'en',
					'value' => 'Example no. 2',
				},
			],
		},
		'title' => 'Q42',
	},
	'Single value.',
);
