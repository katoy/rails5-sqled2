require 'database_cleaner'

def create_shohin
  data = [
    { shohin_id: '0001', shohin_mei: 'Tシャツ', shohin_bunrui: '衣服',
      hanbai_tanka: 1000, shiire_tanka: 500, torokubi: '2009-09-20' },
    { shohin_id: '0002', shohin_mei: '穴あけパンチ', shohin_bunrui: '事務用品',
      hanbai_tanka: 500, shiire_tanka: 320, torokubi: '2009-09-11' },
    { shohin_id: '0003', shohin_mei: 'カッターシャツ', shohin_bunrui: '衣服',
      hanbai_tanka: 4000, shiire_tanka: 2800, torokubi: nil },
    { shohin_id: '0004', shohin_mei: '包丁', shohin_bunrui: 'キッチン用品',
      hanbai_tanka: 3000, shiire_tanka: 2800, torokubi: '2009-09-20' },
    { shohin_id: '0005', shohin_mei: '圧力鍋', shohin_bunrui: 'キッチン用品',
      hanbai_tanka: 6800, shiire_tanka: 5000, torokubi: '2009-01-15' },
    { shohin_id: '0006', shohin_mei: 'フォーク', shohin_bunrui: 'キッチン用品',
      hanbai_tanka: 500, shiire_tanka: nil, torokubi: '2009-09-20' },
    { shohin_id: '0007', shohin_mei: 'おろしがね', shohin_bunrui: 'キッチン用品',
      hanbai_tanka: 880, shiire_tanka: 790, torokubi: '2008-04-28' },
    { shohin_id: '0008', shohin_mei: 'ボールペン', shohin_bunrui: '事務用品',
      hanbai_tanka: 100, shiire_tanka: nil, torokubi: '2009-11-11' }
  ]
  Shohin.create(data)
end

def create_shohin2
  data = [
    { shohin_id: '0001', shohin_mei: 'Tシャツ', shohin_bunrui: '衣服',
      hanbai_tanka: 1000, shiire_tanka: 500, torokubi: '2009-09-20' },
    { shohin_id: '0002', shohin_mei: '穴あけパンチ', shohin_bunrui: '事務用品',
      hanbai_tanka: 500, shiire_tanka: 320, torokubi: '2009-09-11' },
    { shohin_id: '0003', shohin_mei: 'カッターシャツ', shohin_bunrui: '衣服',
      hanbai_tanka: 4000, shiire_tanka: 2800, torokubi: nil },
    { shohin_id: '0009', shohin_mei: '手袋', shohin_bunrui: '衣服',
      hanbai_tanka: 800, shiire_tanka: 500, torokubi: nil },
    { shohin_id: '0010', shohin_mei: 'やかん', shohin_bunrui: 'キッチン用品',
      hanbai_tanka: 2000, shiire_tanka: 1700, torokubi: '2009-09-20' }
  ]
  Shohin2.create(data)
end

def create_chars
  Char.create(chr: '1')
  Char.create(chr: '2')
  Char.create(chr: '3')
  Char.create(chr: '10')
  Char.create(chr: '11')
  Char.create(chr: '222')
end

def create_tenpo_shohin
  data = [
    { tenpo_id: '000A', tenpo_mei: '東京',  shohin_id: '0001', suryo: 30 },
    { tenpo_id: '000A', tenpo_mei: '東京',  shohin_id: '0002', suryo: 50 },
    { tenpo_id: '000A', tenpo_mei: '東京',  shohin_id: '0003', suryo: 1 },
    { tenpo_id: '000B', tenpo_mei: '名古屋', shohin_id: '0002', suryo: 30 },
    { tenpo_id: '000B', tenpo_mei: '名古屋', shohin_id: '0003', suryo: 12 },
    { tenpo_id: '000B', tenpo_mei: '名古屋', shohin_id: '0004', suryo: 20 },
    { tenpo_id: '000B', tenpo_mei: '名古屋', shohin_id: '0006', suryo: 10 },
    { tenpo_id: '000B', tenpo_mei: '名古屋', shohin_id: '0007', suryo: 40 },
    { tenpo_id: '000C', tenpo_mei: '大阪',  shohin_id: '0003', suryo: 20 },
    { tenpo_id: '000C', tenpo_mei: '大阪',  shohin_id: '0004', suryo: 50 },
    { tenpo_id: '000C', tenpo_mei: '大阪',  shohin_id: '0006', suryo: 90 },
    { tenpo_id: '000C', tenpo_mei: '大阪',  shohin_id: '0007', suryo: 70 },
    { tenpo_id: '000D', tenpo_mei: '福岡',  shohin_id: '0001', suryo: 100 }
  ]
  TenpoShohin.create(data)
end

def create_zaiko_shohin
  data = [
    { souko_id: 'S001', shohin_id: '0001', zaiko_suryo: 0 },
    { souko_id: 'S001', shohin_id: '0002', zaiko_suryo: 120 },
    { souko_id: 'S001', shohin_id: '0003', zaiko_suryo: 200 },
    { souko_id: 'S001', shohin_id: '0004', zaiko_suryo: 3 },
    { souko_id: 'S001', shohin_id: '0005', zaiko_suryo: 0 },
    { souko_id: 'S001', shohin_id: '0006', zaiko_suryo: 99 },
    { souko_id: 'S001', shohin_id: '0007', zaiko_suryo: 999 },
    { souko_id: 'S001', shohin_id: '0008', zaiko_suryo: 200 },
    { souko_id: 'S002', shohin_id: '0001', zaiko_suryo: 10 },
    { souko_id: 'S002', shohin_id: '0002', zaiko_suryo: 25 },
    { souko_id: 'S002', shohin_id: '0003', zaiko_suryo: 34 },
    { souko_id: 'S002', shohin_id: '0004', zaiko_suryo: 19 },
    { souko_id: 'S002', shohin_id: '0005', zaiko_suryo: 99 },
    { souko_id: 'S002', shohin_id: '0006', zaiko_suryo: 0 },
    { souko_id: 'S002', shohin_id: '0007', zaiko_suryo: 0 },
    { souko_id: 'S002', shohin_id: '0008', zaiko_suryo: 18 }
  ]
  ZaikoShohin.create(data)
end

DatabaseCleaner.clean_with(:truncation)
create_shohin
create_shohin2
create_chars
create_tenpo_shohin
create_zaiko_shohin
