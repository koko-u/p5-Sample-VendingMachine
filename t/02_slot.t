use Test::Most;
use Sample::Slot;
use YAML;

subtest "スロットの生成" => sub {
    subtest "名前、価格、在庫を指定" => sub {
        my $slot = Sample::Slot->new('コーラ', price => 120, stock => 5);
        isa_ok($slot, 'Sample::Slot', "Slotオブジェクトが得られる");
        is($slot->name, 'コーラ', "名前が得られる");
        is($slot->price, 120, "値段は120円");
        is($slot->stock,   5, "在庫は5個");
    };

    subtest "在庫を指定せずに作成" => sub {
        my $slot = Sample::Slot->new('コーラ', price => 120);
        is($slot->stock, 0, "在庫は0個");
    };

    subtest "価格を指定せずに作成" => sub {
        dies_ok { Sample::Slot->new('コーラ', stock => 5) },
            "価格のない商品のSlotは作成できない";
    };
};

subtest "スロットの商品を購入" => sub {
    my $init = sub {
        my $slot = Sample::Slot->new('コーラ', price => 120, stock => 5);
        return $slot;
    };
    subtest "金額不足(100円)で購入しようとした" => sub {
        my $slot = $init->();
        my $given = 100;
        ok((not $slot->buyable_by($given)), "購入できない");

        $slot->buy_by($given);
        is($slot->stock, 5, "買おうとしても在庫は減らない");
    };
    subtest "金額十分(120円)で購入しようとした" => sub {
        my $slot = $init->();
        my $given = 120;
        ok($slot->buyable_by($given), "購入できる");

        $slot->buy_by($given);
        is($slot->stock, 4, "購入すると在庫が減る");
    };
    subtest "Slot の在庫が無い場合" => sub {
        my $slot = Sample::Slot->new('コーラ', price => 120, stock => 0);
        my $given = 120;
        ok((not $slot->buyable_by($given)), "金額が十分でも購入できない");

        $slot->buy_by($given);
        is($slot->stock, 0, "購入しようとしても在庫ゼロから減らない");
    };
};

done_testing;
