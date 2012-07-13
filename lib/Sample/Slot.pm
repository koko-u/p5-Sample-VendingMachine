package Sample::Slot;
use strict;
use warnings;

our $VERSION = '0.01';

sub new {
    my $class = shift;
    my $name = shift;
    my $self = {
        name => $name,
        price => 0,
        stock => 0,
        @_,
    };
    return bless $self, $class;
}

sub name {
    return $_[0]->{name};
}

sub price {
    return $_[0]->{price};
}

sub stock {
    return $_[0]->{stock};
}

sub buyable_by {
    my ($self, $total) = @_;
    return $self->price <= $total && $self->stock > 0;
}

sub buy_by {
    my ($self, $total) = @_;
    $self->{stock}-- if $self->buyable_by($total);
}

1;
