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
            is_deeply(\@products, ['コーラ', '爽健美茶', '六甲のおいしい水']);
        };
        it "購入可能な商品はない" => sub {
            ok(not $vm->buyables);
        };
    };
    context "100円を投入した状態" => sub {
        before each => sub { $vm->put_in(100); };
        it "六甲のおいしい水が購入可能"  => sub {
            my @buyables = $vm->buyables;
            is_deeply(\@buyables, ['六甲のおいしい水']);
        };
    };
};

runtests unless caller;
