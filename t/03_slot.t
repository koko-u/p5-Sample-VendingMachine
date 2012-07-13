use Test::Spec;
use Sample::Slot;

describe "ジュースのストック" => sub {
    describe "オブジェクトの生成" => sub {
        context "通常の生成" => sub {
            it "各属性が得られる" => sub {
                my $slot = Sample::Slot->new('コーラ', price => 120, stock => 5);
                is($slot->name, 'コーラ');
                is($slot->price, 120);
                is($slot->stock, 5);
            };
        };
        context "在庫の指定がない" => sub {
            it "在庫はゼロ" => sub {
                my $slot = Sample::Slot->new('コーラ', price => 120);
                is($slot->name, 'コーラ');
                is($slot->price, 120);
                is($slot->stock, 0);
            };
        };
        context "価格の指定がない" => sub {
            it "値段はゼロ円" => sub {
                my $slot = Sample::Slot->new('コーラ', stock => 5);
                is($slot->name, 'コーラ');
                is($slot->price, 0);
                is($slot->stock, 5);
            };
        };
    };
    describe "購入する" => sub {
        my $slot;
        my $total;
        before each => sub {
            $slot = Sample::Slot->new('コーラ', price => 120, stock => 5);
        };
        context "金額が不足している" => sub {
            before each => sub { $total = 100; };
            it "購入できない" => sub {
                ok(not $slot->buyable_by($total));
            };
            it "購入しても在庫は減らない" => sub {
                $slot->buy_by($total);
                is($slot->stock, 5);
            };
        };
        context "金額が十分" => sub {
            before each => sub { $total = 120; };
            it "購入できる" => sub {
                ok($slot->buyable_by($total));
            };
            it "購入すると在庫が減る" => sub {
                $slot->buy_by($total);
                is($slot->stock, 4);
            };
        };
        context "在庫が不足" => sub {
            before each => sub {
                $slot = Sample::Slot->new('コーラ', price => 120);
                $total = 120;
            };
            it "購入できない" => sub {
                ok(not $slot->buyable_by($total));
            };
        };
    };
};

runtests unless caller;
