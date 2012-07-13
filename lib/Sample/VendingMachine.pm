package Sample::VendingMachine;
use strict;
use warnings;
use feature 'switch';

our $VERSION = '0.01';

sub new {
    my $class = shift;
    my $self = {
        total => 0,
        change => 0,
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
    return ('コーラ');
}

sub buyables {
    return ();
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
