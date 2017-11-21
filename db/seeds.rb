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
  Shohin.create!(data)
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
  Shohin2.create!(data)
end

def create_chars
  Char.create!(chr: '1')
  Char.create!(chr: '2')
  Char.create!(chr: '3')
  Char.create!(chr: '10')
  Char.create!(chr: '11')
  Char.create!(chr: '222')
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
  TenpoShohin.create!(data)
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
  ZaikoShohin.create!(data)
end

def create_household
  data = [
    { day: '2013-02-03', item: '食費', memo: 'コーヒーを購入',
      income: 0, outcome: 380 },
    { day: '2013-02-10', item: '給料', memo: '1月の給料',
      income: 280_000, outcome: 0 },
    { day: '2013-02-11', item: '教養娯楽費', memo: '書籍を購入',
      income: 0, outcome: 2800 },
    { day: '2013-02-14', item: '交際費', memo: '同期会の会費',
      income: 0, outcome: 5000 },
    { day: '2013-02-18', item: '水道光熱費', memo: '1月の電気代',
      income: 0, outcome: 7560 }
  ]
  Household.create!(data)
end

def create_household_archive
  data = [
    { day: '2012-12-10', item: '給料', memo: '11月の給料',
      income: 280000, outcome: 0 },
    { day: '2012-12-18', item: '水道光熱費', memo: '水道代',
      income: 0, outcome: 4200 },
    { day: '2012-12-24', item: '食費', memo: 'レストランみやび',
      income: 0, outcome: 5000 },
    { day: '2012-12-25', item: '居住費', memo: '1月の家賃支払い',
      income: 0, outcome: 80000 },
    { day: '2013-01-10', item: '給料', memo: '12月の給料',
      income: 280000, outcome: 0 },
    { day: '2013-01-13', item: '教養娯楽費', memo: 'スッキリシネマズ',
      income: 0, outcome: 1800 },
    { day: '2013-01-13', item: '食費', memo: '新年会',
      income: 0, outcome: 5000 },
    { day: '2013-01-25', item: '居住費', memo: '2月の家賃支払い',
      income: 0, outcome: 80000 }
  ]
  HouseholdArchive.create!(data)
end

def create_summary
  data = [
    { item: '居住費', total: 160000, average: 80000, max: 80000, min: 80000, count: 3 },
    { item: '水道光熱費', total: 11760, average: 5880, max: 7560, min: 4200, count: 2 },
    { item: '食費', total: 10380, average: 3460, max: 5000, min: 380, count: 3 },
    { item: '教養娯楽費', total: 4600, average: 2300, max: 2800, min: 1800, count: 2 },
    { item: '給料',	total: 840000, average: 280000, max: 280000, min: 280000, count: 3 }
  ]
  Summary.create!(data)
end

def create_expense_categories
  data = [
    { id: 1, name: '支出' },
    { id: 2, name: '収入' }
  ]
  ExpenseCategory.create!(data)
end

def create_items
  data = [
    { id: 1, name: '給料',      expense_category_id: 2, memo: '給与や賞与が入った' },
    { id: 2, name: '食費',      expense_category_id: 1, memo: '食事代（ただし飲み会などの外食を除く）' },
    { id: 3, name: '水道光熱費', expense_category_id: 1, memo: '水道代・電気代・ガス代' }
  ]
  Item.create!(data)
end

def create_householdx
  data = [
    { day: '2013-02-03', item_id: 2, memo: 'カフェラテを購入', income: 0, outcome: 380 },
    { day: '2013-02-05', item_id: 2, memo: '昼食（日の出食堂）', income: 0, outcome: 750 },
    { day: '2013-02-10', item_id: 1, memo: '1月の給料',  income: 280000, outcome: 0 }
  ]
  Householdx.create!(data)
end

DatabaseCleaner.clean_with(:truncation)
create_shohin
create_shohin2
create_chars
create_tenpo_shohin
create_zaiko_shohin
create_household
create_household_archive
create_summary

create_expense_categories
create_items
create_householdx
