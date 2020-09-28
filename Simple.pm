package Wikidata::Simple;

use strict;
use warnings;

use Class::Utils qw(set_params);
use Error::Pure qw(err);
use Wikidata::Datatype::Snak;
use Wikidata::Datatype::Statement;
use Wikidata::Datatype::Struct::Statement;
use Wikidata::Datatype::Value::Item;

our $VERSION = 0.01;

sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Entity.
	$self->{'entity'} = undef;

	# Claims.
	$self->{'claims'} = [];

	# Process parameters.
	set_params($self, @params);

	# Check entity.
	if (defined $self->{'entity'} && $self->{'entity'} !~ m/^Q\d+$/ms) {
		err "Parameter 'entity' must contain string with Q on begin and numbers.";
	}

	# Check claims.
	if (ref $self->{'claims'} ne 'ARRAY') {
		err "Parameter 'claims' must be a array.";
	}
	foreach my $claim (@{$self->{'claims'}}) {
		if (! $claim->isa('Wikidata::Datatype::Statement')) {
			err "Parameter 'claims' must contain 'Wikidata::Datatype::Statement' ".
				'objects only.';
		}
	}

	return $self;
}

sub add_claim_item {
	my ($self, $claim_hr) = @_;

	my $property = $self->_get_property($claim_hr);

	push @{$self->{'claims'}}, Wikidata::Datatype::Statement->new(
		'entity' => $self->{'entity'},
		$claim_hr->{'rank'} ? (
			'rank' => $claim_hr->{'rank'},
		) : (),
		'snak' => Wikidata::Datatype::Snak->new(
			'datatype' => 'wikibase-item',
			'datavalue' => Wikidata::Datatype::Value::Item->new(
				'value' => $claim_hr->{$property},
			),
			'property' => $property,
		),
		# TODO Add references
	);

	return
}

sub parse {
	my ($self, $struct_hr) = @_;

	# Title.
	$self->{'entity'} = $struct_hr->{'title'};

	# Claims.
	foreach my $claim_property (keys %{$struct_hr->{'claims'}}) {
		foreach my $claim_hr (@{$struct_hr->{'claims'}->{$claim_property}}) {
			push @{$self->{'claims'}},
				Wikidata::Datatype::Struct::Statement::struct2obj(
					$claim_hr, $self->{'entity'},
				);
		}
	}

	# Labels.
	# TODO

	# Descriptions.
	# TODO

	# Aliases.
	# TODO

	# Sitelinks.
	# TODO

	return;
}

sub serialize {
	my $self = shift;

	my $struct_hr = {};

	# Title
	if (defined $self->{'entity'}) {
		$struct_hr->{'title'} = $self->{'entity'};
	}

	# Descriptions.
	# TODO

	# Labels.
	# TODO

	# Claims.
	foreach my $claim (@{$self->{'claims'}}) {
		if (! exists $struct_hr->{'claims'}->{$claim->snak->property}) {
			$struct_hr->{'claims'}->{$claim->snak->property} = [];
		}
		push @{$struct_hr->{'claims'}->{$claim->snak->property}},
			Wikidata::Datatype::Struct::Statement::obj2struct($claim);
	}

	return $struct_hr;
}

sub _get_property {
	my ($self, $claim_hr) = @_;

	my @p;
	foreach my $key (keys %{$claim_hr}) {
		if ($key =~ m/^P\d+$/ms) {
			push @p, $key;
		}
	}

	if (@p > 1) {
		err 'Multiple properties.';
	} elsif (@p == 0) {
		err 'No property.';
	}

	return $p[0];
}

1;
