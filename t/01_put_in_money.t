use Test::Spec;

use Sample::VendingMachine;

describe "自販機" => sub {
    my $vm;
    before each => sub {
        $vm = Sample::VendingMachine->new;
    };
    context "何も硬貨を投入しない状態" => sub {
        it "合計はゼロ円" => sub {
            is($vm->total, 0);
        };
        context "払い戻した" => sub {
            before each => sub {
                $vm->back;
            };
            it "お釣りはゼロ円" => sub {
                is($vm->change, 0);
            };
        };
    };
    context "100円硬貨と50円硬貨を投入した" => sub {
        before each => sub {
            $vm->put_in(100); $vm->put_in(50);
        };
        it "合計は150円" => sub {
            is($vm->total, 150);
        };
        context "払い戻した" => sub {
            before each => sub {
                $vm->back;
            };
            it "お釣りは150円" => sub {
                is($vm->change, 150);
            };
            it "合計はゼロ円に戻る" => sub {
                is($vm->total, 0);
            };
        };
    };
    context "扱えない硬貨を投入した" => sub {
        before each => sub {
            $vm->put_in(5);
        };
        it "合計は加算されない" => sub {
            is($vm->total, 0);
        };
        it "お釣りとしてすぐ戻る" => sub {
            is($vm->change, 5);
        };
    };
};

runtests unless caller;
