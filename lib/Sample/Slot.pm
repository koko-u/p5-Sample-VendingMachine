package Sample::Slot;
use strict;
use warnings;

use Sub::Args;
our $VERSION = '0.01';

sub new {
    my $class = shift;
    my $name = shift;
    my $args = args({
        price => 1,
        stock => 0,
    }, @_);
    my $self = {
        name => $name,
        price => $args->{price},
        stock => $args->{stock} // 0,
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
