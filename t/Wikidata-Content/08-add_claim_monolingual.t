use strict;
use warnings;

use Test::More 'tests' => 3;
use Test::NoWarnings;
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
$obj->add_claim_monolingual({'P1476' => {'language' => 'en', 'value' => 'foo'}});
my $ret_hr = $obj->serialize;
is_deeply(
	$ret_hr,
	{
		'claims' => {
			'P1476' => [
				{
					'mainsnak' => {
						'datatype' => 'monolingualtext',
						'datavalue' => {
							'type' => 'monolingualtext',
							'value' => {
								'text' => 'foo',
								'language' => 'en',
							},
						},
						'property' => 'P1476',
						'snaktype' => 'value',
					},
					'rank' => 'normal',
					'type' => 'statement',
				},
			],
		},
		'title' => 'Q42',
	},
	'Single value with explicit language.',
);

# Test.
$obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
$obj->add_claim_monolingual({'P1476' => 'foo'});
$ret_hr = $obj->serialize;
is_deeply(
	$ret_hr,
	{
		'claims' => {
			'P1476' => [
				{
					'mainsnak' => {
						'datatype' => 'monolingualtext',
						'datavalue' => {
							'type' => 'monolingualtext',
							'value' => {
								'text' => 'foo',
								'language' => 'en',
							},
						},
						'property' => 'P1476',
						'snaktype' => 'value',
					},
					'rank' => 'normal',
					'type' => 'statement',
				},
			],
		},
		'title' => 'Q42',
	},
	"Single value with default 'en' language.",
);
