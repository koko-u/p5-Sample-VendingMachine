use Test::Most;

use Sample::VendingMachine;

subtest "最初の状態" => sub {
    my $vm = Sample::VendingMachine->new;
    is($vm->total, 0, "合計はゼロ円");

    $vm->back;
    is($vm->change, 0, "お釣りはゼロ円");

    my @products = $vm->products;
    cmp_bag(
        \@products,
        ['コーラ', '爽健美茶', '六甲のおいしい水'],
        "取扱い商品の一覧が得られる"
    );

    is(scalar $vm->buyables, 0, "購入可能な商品はない");
};

subtest "使えない硬貨を投入" => sub {
    my $vm = Sample::VendingMachine->new;
    $vm->put_in(5);
    is($vm->total, 0, "合計はゼロ円のまま");
    is($vm->change, 5, "払い戻すまでもなくお釣りは5円");
};

subtest "100円を投入" => sub {
    my $init = sub {
        my $vm = Sample::VendingMachine->new;
        $vm->put_in(100);
        return $vm;
    };
    my $vm = $init->();
    my @buyables = $vm->buyables;
    cmp_deeply(\@buyables, superbagof('六甲のおいしい水'),
               "100円以下の商品が購入できる");

    subtest "..購入ボタンを押した" => sub {
        my $vm = $init->();
        $vm->buy('六甲のおいしい水');
        is($vm->total, 0, "合計額はゼロに");
        is($vm->sales, 100, "100円の売上げ");
    };

    subtest "..関係ないボタンを押した" => sub {
        my $vm = $init->();
        $vm->buy('コーラ');
        is($vm->total, 100, "合計額に変化なし");
        is($vm->sales,   0, "売上はない");
    };
};

subtest "100円と50円を投入" => sub {
    my $init = sub {
        my $vm = Sample::VendingMachine->new;
        $vm->put_in(100); $vm->put_in(50);
        return $vm;
    };
    my $vm = $init->();
    is($vm->total, 150, "合計は150円");

    my @buyables = $vm->buyables;
    cmp_bag(\@buyables,
            ['コーラ', '爽健美茶', '六甲のおいしい水'],
            'すべての商品が購入可能');

    subtest "..すぐ払い戻した" => sub {
        my $vm = $init->();
        $vm->back;
        is($vm->change, 150, "お釣りは150円");
        is($vm->total,    0, "合計はゼロ円に戻る");
    };

    subtest "..120円のコーラを買った" => sub {
        my $vm = $init->();
        $vm->buy('コーラ');
        is($vm->total,   0, "合計額はゼロ円に");
        is($vm->change, 30, "30円では何も買えないので釣り銭として戻ってくる");
        is($vm->sales, 120, "売上は120円");
    };
};

subtest "500円を投入" => sub {
    my $init = sub {
        my $vm = Sample::VendingMachine->new;
        $vm->put_in(500);
        return $vm;
    };
    subtest "..120円のコーラを買った" => sub {
        my $vm = $init->();
        $vm->buy('コーラ');
        is($vm->total, 380, "合計額は320円に");
        is($vm->change,  0, "未だ残額は十分あるので自動的に釣り銭は戻らない");
        is($vm->sales, 120, "売上は120円");
    };


};

done_testing;
