package Sample::VendingMachine;
use strict;
use warnings;
use feature 'switch';

our $VERSION = '0.01';

use Sample::Slot;

sub new {
    my $class = shift;
    my $self = {
        total => 0,
        change => 0,
        slots => [
            Sample::Slot->new('コーラ', price => 120, stock => 5),
            Sample::Slot->new('爽健美茶', price => 150, stock => 10),
            Sample::Slot->new('六甲のおいしい水', price => 100, stock => 5),
        ],
    };
    return bless $self, $class;
}

sub total {
    return $_[0]->{total};
}

sub change {
    return $_[0]->{change};
}

sub put_in {
    my ($self, $money) = @_;
    given($money) {
        when([10, 50, 100, 500, 1000]) {
            $self->{total} += $money;
        }
        default {
            $self->{change} += $money;
        }
    }
}

sub back {
    my $self = shift;
    $self->{change} = $self->total;
    $self->{total} = 0;
}

sub products {
    my $self = shift;
    return map { $_->name } @{$self->{slots}};
}

sub buyables {
    my $self = shift;
    return map { $_->name }
        grep { $_->buyable_by($self->total) } @{$self->{slots}};
}

1;
__END__

=head1 NAME

Sample::VendingMachine -

=head1 SYNOPSIS

  use Sample::VendingMachine;

=head1 DESCRIPTION

Sample::VendingMachine is

=head1 AUTHOR

kozaki tsuneaki E<lt>kozaki.tsuneaki@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
