package Wikidata::Content;

use strict;
use warnings;

use Class::Utils qw(set_params);
use Error::Pure qw(err);
use Wikidata::Datatype::Snak;
use Wikidata::Datatype::Statement;
use Wikidata::Datatype::Struct::Statement;
use Wikidata::Datatype::Value::Item;
use Wikidata::Datatype::Value::Monolingual;

our $VERSION = 0.01;

sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Aliases.
	$self->{'aliases'} = [];

	# Claims.
	$self->{'claims'} = [];

	# Descriptions.
	$self->{'descriptions'} = [];

	# Entity.
	$self->{'entity'} = undef;

	# Labels.
	$self->{'labels'} = [];

	# Process parameters.
	set_params($self, @params);

	# Check aliases.
	if (ref $self->{'aliases'} ne 'ARRAY') {
		err "Parameter 'aliases' must be a reference to array.";
	}
	foreach my $alias (@{$self->{'aliases'}}) {
		if (! $alias->isa('Wikidata::Datatype::Value::Monolingual')) {
			err "Parameter 'alias' must contain 'Wikidata::Datatype::Value::Monolingual' ".
				'objects only.';
		}
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

	# Check descriptions.
	if (ref $self->{'descriptions'} ne 'ARRAY') {
		err "Parameter 'descriptions' must be a array.";
	}
	foreach my $description (@{$self->{'descriptions'}}) {
		if (! $description->isa('Wikidata::Datatype::Value::Monolingual')) {
			err "Parameter 'descriptions' must contain 'Wikidata::Datatype::Value::Monolingual' ".
				'objects only.';
		}
	}

	# Check entity.
	if (defined $self->{'entity'} && $self->{'entity'} !~ m/^Q\d+$/ms) {
		err "Parameter 'entity' must contain string with Q on begin and numbers.";
	}

	# Check labels.
	if (ref $self->{'labels'} ne 'ARRAY') {
		err "Parameter 'labels' must be a array.";
	}
	foreach my $label (@{$self->{'labels'}}) {
		if (! $label->isa('Wikidata::Datatype::Value::Monolingual')) {
			err "Parameter 'labels' must contain 'Wikidata::Datatype::Value::Monolingual' ".
				'objects only.';
		}
	}

	return $self;
}

sub add_aliases {
	my ($self, $aliases_hr) = @_;

	return $self->_add_monolingual($aliases_hr, 'aliases')
}

sub add_claim_item {
	my ($self, $claim_hr) = @_;

	my $property = $self->_get_property($claim_hr);

	push @{$self->{'claims'}},
		map { $self->_add_claim_item($claim_hr, $property, $_) }
		$self->_process_values($claim_hr->{$property},
			'Unsupported reference for claim value.');

	return;
}

sub add_claim_string {
	my ($self, $claim_hr) = @_;

	my $property = $self->_get_property($claim_hr);

	push @{$self->{'claims'}},
		map { $self->_add_claim_string($claim_hr, $property, $_) }
		$self->_process_values($claim_hr->{$property},
			'Unsupported reference for claim value.');

	return;
}

sub add_descriptions {
	my ($self, $descs_hr) = @_;

	return $self->_add_monolingual($descs_hr, 'descriptions')
}

sub add_labels {
	my ($self, $labels_hr) = @_;

	return $self->_add_monolingual($labels_hr, 'labels')
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

	# Descriptions.
	foreach my $descriptions_hr (values %{$struct_hr->{'descriptions'}}) {
		$self->add_descriptions({
			$descriptions_hr->{'language'} => $descriptions_hr->{'value'}
		});
	}

	# Labels.
	foreach my $label_hr (values %{$struct_hr->{'labels'}}) {
		$self->add_labels({
			$label_hr->{'language'} => $label_hr->{'value'}
		});
	}

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

	# Aliases.
	foreach my $alias (@{$self->{'aliases'}}) {
		if (! exists $struct_hr->{'aliases'}) {
			$struct_hr->{'aliases'} = {};
		}
		if (! exists $struct_hr->{'aliases'}->{$alias->language}) {
			$struct_hr->{'aliases'}->{$alias->language} = [];
		}
		push @{$struct_hr->{'aliases'}->{$alias->language}}, {
			'value' => $alias->value,
			'language' => $alias->language,
		};
	}

	# Descriptions.
	foreach my $description (@{$self->{'descriptions'}}) {
		$struct_hr->{'descriptions'}->{$description->language} = {
			'value' => $description->value,
			'language' => $description->language,
		};
	}

	# Labels.
	foreach my $label (@{$self->{'labels'}}) {
		$struct_hr->{'labels'}->{$label->language} = {
			'value' => $label->value,
			'language' => $label->language,
		};
	}

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

sub _add_claim_item {
	my ($self, $claim_hr, $property, $claim_value) = @_;

	return Wikidata::Datatype::Statement->new(
		'entity' => $self->{'entity'},
		$claim_hr->{'rank'} ? (
			'rank' => $claim_hr->{'rank'},
		) : (),
		'snak' => Wikidata::Datatype::Snak->new(
			'datatype' => 'wikibase-item',
			'datavalue' => Wikidata::Datatype::Value::Item->new(
				'value' => $claim_value,
			),
			'property' => $property,
		),
		# TODO Add references
	);
}

sub _add_claim_string {
	my ($self, $claim_hr, $property, $claim_value) = @_;

	return Wikidata::Datatype::Statement->new(
		'entity' => $self->{'entity'},
		$claim_hr->{'rank'} ? (
			'rank' => $claim_hr->{'rank'},
		) : (),
		'snak' => Wikidata::Datatype::Snak->new(
			'datatype' => 'string',
			'datavalue' => Wikidata::Datatype::Value::String->new(
				'value' => $claim_value,
			),
			'property' => $property,
		),
		# TODO Add references
	);
}

sub _add_monolingual {
	my ($self, $struct_hr, $key) = @_;

	foreach my $lang (keys %{$struct_hr}) {
		push @{$self->{$key}},
			map {
				Wikidata::Datatype::Value::Monolingual->new(
					'language' => $lang,
					'value' => $_,
				);
			}
			$self->_process_values($struct_hr->{$lang},
				'Unsupported reference for alias value.');
	}

	return;
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

sub _process_values {
	my ($self, $value, $err_msg) = @_;

	if (ref $value eq 'ARRAY') {
		return @{$value};
	} elsif (ref $value eq '') {
		return $value;
	} else {
		err $err_msg;
	}
}

1;
