use strict;
use warnings;

use Test::More 'tests' => 2;
use Test::NoWarnings;
use Wikidata::Content;

# Test.
my $obj = Wikidata::Content->new(
	'entity' => 'Q42',
);
$obj->add_claim_monolingual({'P1476' => [['en', 'foo']]});
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
	'Single value.',
);
