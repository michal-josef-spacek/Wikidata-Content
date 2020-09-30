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
$obj->add_descriptions({'cs' => decode_utf8('Příklad'), 'en' => 'Example'});
my $ret_hr = $obj->serialize;
is_deeply(
	$ret_hr,
	{
		'descriptions' => {
			'cs' => {
				'language' => 'cs',
				'value' => decode_utf8('Příklad'),
			},
			'en' => {
				'language' => 'en',
				'value' => 'Example',
			},
		},
		'title' => 'Q42',
	},
	'Multiple descriptions.',
);

