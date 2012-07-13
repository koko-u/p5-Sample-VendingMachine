use Test::Spec;
use Sample::VendingMachine;

describe "自販機" => sub {
    my $vm;
    before each => sub {
        $vm = Sample::VendingMachine->new;
    };
    context "何もしていない状態" => sub {
        it "格納されているジュースのリストが得られる" => sub {
            my @products = $vm->products;
            is_deeply(\@products, ['コーラ']);
        };
        it "購入可能な商品はない" => sub {
            ok(not $vm->buyables);
        };
    };
};

runtests unless caller;
