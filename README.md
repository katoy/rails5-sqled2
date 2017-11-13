
書籍 "ゼロからはじめるデータベース操作 第2版" にあるサンプルを MySQL + Rails 5 で試してみた。
     https://www.amazon.co.jp/dp/B01HD5VWWO

準備
----

    Mac で作成例：

    $ rails new rails5-sqled2 --api -d mysql
    $ cd rails5-sqled2
    ( $ xcode-select --install )
    $ bundle config build.nokogiri -- --with-xml2-dir=/usr/local --with-xslt-dir=/usr/local \        
      --with-iconv-dir=/usr/local
    $ bundle install --path vendor/bundle

    $ rails db:drop  # 必要に応じて
    # 　エラーになったら
    #  　 $ bin/rails db:environment:set RAILS_ENV=development
    # 　を実行する

    $ rails db:create
    $ rails db:migrate
    $ rails db:seed

Select
--------

## list 2-1 Shohin テーブルから 3 つの列を出力

```
> Shohin.select(:shohin_id, :shohin_mei, :shiire_tanka)
Shohin Load (0.4ms)  SELECT `Shohin`.`shohin_id`, `Shohin`.`shohin_mei`, `Shohin`.`shiire_tanka` FROM `Shohin`
+-----------+----------------+--------------+
| shohin_id | shohin_mei     | shiire_tanka |
+-----------+----------------+--------------+
| 0001      | Tシャツ        | 500          |
| 0002      | 穴あけパンチ   | 320          |
| 0003      | カッターシャツ | 2800         |
| 0004      | 包丁           | 2800         |
| 0005      | 圧力鍋         | 5000         |
| 0006      | フォーク       |              |
| 0007      | おろしがね     | 790          |
| 0008      | ボールペン     |              |
+-----------+----------------+--------------+
8 rows in set
```

## list 2-2. Shohin テーブルのすべての列を出力

```
> Shohin.all
Shohin Load (0.6ms)  SELECT `Shohin`.* FROM `Shohin`
+-----------+----------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei     | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+----------------+---------------+--------------+--------------+------------+
| 0001      | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 0002      | 穴あけパンチ   | 事務用品      | 500          | 320          | 2009-09-11 |
| 0003      | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 0004      | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 0005      | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 0006      | フォーク       | キッチン用品  | 500          |              | 2009-09-20 |
| 0007      | おろしがね     | キッチン用品  | 880          | 790          | 2008-04-28 |
| 0008      | ボールペン     | 事務用品      | 100          |              | 2009-11-11 |
+-----------+----------------+---------------+--------------+--------------+------------+
8 rows in set
```

## list 2-3. 2-2 と同じ意味の SELECT

```
> Shohin.select(:shohin_id, :shohin_mei, :shohin_bunrui, :hanbai_tanka, :shiire_tanka, :torokubi)
  Shohin Load (0.4ms)  SELECT `Shohin`.`shohin_id`, `Shohin`.`shohin_mei`, `Shohin`.`shohin_bunrui`, `Shohin`.`hanbai_tanka`, `Shohin`.`shiire_tanka`, `Shohin`.`torokubi` FROM `Shohin`
+-----------+----------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei     | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+----------------+---------------+--------------+--------------+------------+
| 0001      | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 0002      | 穴あけパンチ   | 事務用品      | 500          | 320          | 2009-09-11 |
| 0003      | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 0004      | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 0005      | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 0006      | フォーク       | キッチン用品  | 500          |              | 2009-09-20 |
| 0007      | おろしがね     | キッチン用品  | 880          | 790          | 2008-04-28 |
| 0008      | ボールペン     | 事務用品      | 100          |              | 2009-11-11 |
+-----------+----------------+---------------+--------------+--------------+------------+
8 rows in set

```

## list 2-4. 列に別名をつける

```
> Shohin.select('shohin_id as id, shohin_mei name, shiire_tanka as tanka')
  Shohin Load (0.5ms)  SELECT shohin_id as id, shohin_mei name, shiire_tanka as tanka FROM `Shohin`
+-----------+----+----------------+-------+
| shohin_id | id | name           | tanka |
+-----------+----+----------------+-------+
|           |    | Tシャツ        | 500   |
|           |    | 穴あけパンチ   | 320   |
|           |    | カッターシャツ | 2800  |
|           |    | 包丁           | 2800  |
|           |    | 圧力鍋         | 5000  |
|           |    | フォーク       |       |
|           |    | おろしがね     | 790   |
|           |    | ボールペン     |       |
+-----------+----+----------------+-------+
8 rows in set
```

## list 2-5. 列に日本語で別名をつける

```
> Shohin.select('shohin_id as "商品ID", shohin_mei as "商品名", shiire_tanka as "仕入れ単価"')
  Shohin Load (0.4ms)  SELECT shohin_id as "商品ID", shohin_mei as "商品名", shiire_tanka as "仕入れ単価" FROM `Shohin`
+-----------+--------+----------------+------------+
| shohin_id | 商品ID | 商品名         | 仕入れ単価 |
+-----------+--------+----------------+------------+
|           | 0001   | Tシャツ        | 500        |
|           | 0002   | 穴あけパンチ   | 320        |
|           | 0003   | カッターシャツ | 2800       |
|           | 0004   | 包丁           | 2800       |
|           | 0005   | 圧力鍋         | 5000       |
|           | 0006   | フォーク       |            |
|           | 0007   | おろしがね     | 790        |
|           | 0008   | ボールペン     |            |
+-----------+--------+----------------+------------+
8 rows in set

```

＃# list 2-6. 定数を出力

```
> Shohin.select("'商品' as mojiretsu, 38 as kazu, '2009-02-24' as hizuke, shohin_id, shohin_mei")
  Shohin Load (0.4ms)  SELECT '商品' as mojiretsu, 38 as kazu, '2009-02-24' as hizuke, shohin_id, shohin_mei FROM `Shohin`
+-----------+----------------+-----------+------+------------+
| shohin_id | shohin_mei     | mojiretsu | kazu | hizuke     |
+-----------+----------------+-----------+------+------------+
| 0001      | Tシャツ        | 商品      | 38   | 2009-02-24 |
| 0002      | 穴あけパンチ   | 商品      | 38   | 2009-02-24 |
| 0003      | カッターシャツ | 商品      | 38   | 2009-02-24 |
| 0004      | 包丁           | 商品      | 38   | 2009-02-24 |
| 0005      | 圧力鍋         | 商品      | 38   | 2009-02-24 |
| 0006      | フォーク       | 商品      | 38   | 2009-02-24 |
| 0007      | おろしがね     | 商品      | 38   | 2009-02-24 |
| 0008      | ボールペン     | 商品      | 38   | 2009-02-24 |
+-----------+----------------+-----------+------+------------+
8 rows in set
```

```
> Shohin.find_by_sql("select '商品' as mojiretsu, 38 as kazu, '2009-02-24' as hizuke, shohin_id, shohin_mei from Shohin")
  Shohin Load (0.5ms)  select '商品' as mojiretsu, 38 as kazu, '2009-02-24' as hizuke, shohin_id, shohin_mei from Shohin
+-----------+----------------+-----------+------+------------+
| shohin_id | shohin_mei     | mojiretsu | kazu | hizuke     |
+-----------+----------------+-----------+------+------------+
| 0001      | Tシャツ        | 商品      | 38   | 2009-02-24 |
| 0002      | 穴あけパンチ   | 商品      | 38   | 2009-02-24 |
| 0003      | カッターシャツ | 商品      | 38   | 2009-02-24 |
| 0004      | 包丁           | 商品      | 38   | 2009-02-24 |
| 0005      | 圧力鍋         | 商品      | 38   | 2009-02-24 |
| 0006      | フォーク       | 商品      | 38   | 2009-02-24 |
| 0007      | おろしがね     | 商品      | 38   | 2009-02-24 |
| 0008      | ボールペン     | 商品      | 38   | 2009-02-24 |
+-----------+----------------+-----------+------+------------+
8 rows in set
```

## list 2-7. DISTINCT を使って shohin_bunrui 列の重複を除いた形で出力

```
> Shohin.select(:shohin_bunrui).distinct
  Shohin Load (0.5ms)  SELECT DISTINCT `Shohin`.`shohin_bunrui` FROM `Shohin`
+-----------+---------------+
| shohin_id | shohin_bunrui |
+-----------+---------------+
|           | 衣服          |
|           | 事務用品      |
|           | キッチン用品  |
+-----------+---------------+
3 rows in set

```

## list 2-8. NULLを含む列に DISTIINCT をつけた場合

```
> Shohin.select(:shiire_tanka).distinct
  Shohin Load (140.6ms)  SELECT DISTINCT `Shohin`.`shiire_tanka` FROM `Shohin`
+-----------+--------------+
| shohin_id | shiire_tanka |
+-----------+--------------+
|           | 500          |
|           | 320          |
|           | 2800         |
|           | 5000         |
|           |              |
|           | 790          |
+-----------+--------------+
6 rows in set
```

## list 2-9. 複数の列に DISTINCTを指定した場合

```
> Shohin.select(:shohin_bunrui, :torokubi).distinct
  Shohin Load (0.6ms)  SELECT DISTINCT `Shohin`.`shohin_bunrui`, `Shohin`.`torokubi` FROM `Shohin`
+-----------+---------------+------------+
| shohin_id | shohin_bunrui | torokubi   |
+-----------+---------------+------------+
|           | 衣服          | 2009-09-20 |
|           | 事務用品      | 2009-09-11 |
|           | 衣服          |            |
|           | キッチン用品  | 2009-09-20 |
|           | キッチン用品  | 2009-01-15 |
|           | キッチン用品  | 2008-04-28 |
|           | 事務用品      | 2009-11-11 |
+-----------+---------------+------------+
7 rows in set
```

## list 2-10. shohin_bunrui が 衣服の行を選択する

```
> Shohin.where(shohin_bunrui: '衣服')
  Shohin Load (0.5ms)  SELECT `Shohin`.* FROM `Shohin` WHERE `Shohin`.`shohin_bunrui` = '衣服'
+-----------+----------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei     | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+----------------+---------------+--------------+--------------+------------+
| 0001      | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 0003      | カッターシャツ | 衣服          | 4000         | 2800         |            |
+-----------+----------------+---------------+--------------+--------------+------------+
2 rows in set
```

## list 2-11. 検索条件の列を出力しない

```
> Shohin.where(shohin_bunrui: '衣服').select(:shohin_mei)
  Shohin Load (0.6ms)  SELECT `Shohin`.`shohin_mei` FROM `Shohin` WHERE `Shohin`.`shohin_bunrui` = '衣服'
+-----------+----------------+
| shohin_id | shohin_mei     |
+-----------+----------------+
|           | Tシャツ        |
|           | カッターシャツ |
+-----------+----------------+
2 rows in set
```

## list 2-12.

## list 2-13.

## list 2-17. 計算式を書く

```
    > Shohin.select('shohin_mei, hanbai_tanka, hanbai_tanka * 2 as "hanbai_tanka * 2"')
    Shohin Load (0.4ms)  SELECT shohin_mei, hanbai_tanka, hanbai_tanka * 2 as "hanbai_tanka * 2" FROM `Shohin`
    +-----------+----------------+--------------+------------------+
    | shohin_id | shohin_mei     | hanbai_tanka | hanbai_tanka * 2 |
    +-----------+----------------+--------------+------------------+
    |           | Tシャツ        | 1000         | 2000             |
    |           | 穴あけパンチ   | 500          | 1000             |
    |           | カッターシャツ | 4000         | 8000             |
    |           | 包丁           | 3000         | 6000             |
    |           | 圧力鍋         | 6800         | 13600            |
    |           | フォーク       | 500          | 1000             |
    |           | おろしがね     | 880          | 1760             |
    |           | ボールペン     | 100          | 200              |
    +-----------+----------------+--------------+------------------+
    8 rows in set
```

## list 2-18. hanbai_tanka が 500 の行を選択

```
> Shohin.where(hanbai_tanka: 500)
  Shohin Load (0.6ms)  SELECT `Shohin`.* FROM `Shohin` WHERE `Shohin`.`hanbai_tanka` = 500
+-----------+--------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei   | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+--------------+---------------+--------------+--------------+------------+
| 0002      | 穴あけパンチ | 事務用品      | 500          | 320          | 2009-09-11 |
| 0006      | フォーク     | キッチン用品  | 500          |              | 2009-09-20 |
+-----------+--------------+---------------+--------------+--------------+------------+
2 rows in set
```

## list 2-19. hanbai_tanka が 500 でない行を選択

```
> Shohin.where.not(hanbai_tanka: 500)
  Shohin Load (0.8ms)  SELECT `Shohin`.* FROM `Shohin` WHERE (`Shohin`.`hanbai_tanka` != 500)
+-----------+----------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei     | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+----------------+---------------+--------------+--------------+------------+
| 0001      | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 0003      | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 0004      | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 0005      | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 0007      | おろしがね     | キッチン用品  | 880          | 790          | 2008-04-28 |
| 0008      | ボールペン     | 事務用品      | 100          |              | 2009-11-11 |
+-----------+----------------+---------------+--------------+--------------+------------+
6 rows in set
```

## list 2-20. 販売単価が 1000 円以上の行を選択

```
> Shohin.where('hanbai_tanka >= ?', 1000)
  Shohin Load (0.7ms)  SELECT `Shohin`.* FROM `Shohin` WHERE (hanbai_tanka >= 1000)
+-----------+----------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei     | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+----------------+---------------+--------------+--------------+------------+
| 0001      | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 0003      | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 0004      | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 0005      | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
+-----------+----------------+---------------+--------------+--------------+------------+
4 rows in set
```

## list 2-21. 登録日が 2009-09-27 より前の行を選択

```
> Shohin.where('torokubi < ?', '2009-09-27')
  Shohin Load (28.8ms)  SELECT `Shohin`.* FROM `Shohin` WHERE (torokubi < '2009-09-27')
+-----------+--------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei   | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+--------------+---------------+--------------+--------------+------------+
| 0001      | Tシャツ      | 衣服          | 1000         | 500          | 2009-09-20 |
| 0002      | 穴あけパンチ | 事務用品      | 500          | 320          | 2009-09-11 |
| 0004      | 包丁         | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 0005      | 圧力鍋       | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 0006      | フォーク     | キッチン用品  | 500          |              | 2009-09-20 |
| 0007      | おろしがね   | キッチン用品  | 880          | 790          | 2008-04-28 |
+-----------+--------------+---------------+--------------+--------------+------------+
6 rows in set
```

## list 2-22. 条件には計算式も書ける

```
> Shohin.where('hanbai_tanka - shiire_tanka >= ?', 500)
  Shohin Load (28.9ms)  SELECT `Shohin`.* FROM `Shohin` WHERE (hanbai_tanka - shiire_tanka >= 500)
+-----------+----------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei     | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+----------------+---------------+--------------+--------------+------------+
| 0001      | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 0003      | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 0005      | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
+-----------+----------------+---------------+--------------+--------------+------------+
3 rows in set
```

## list 2-23.

## list 2-24. '2' より大きいデータを選択する

```
> Char.where('chr > ?', '2')
  Char Load (22.6ms)  SELECT `Chars`.* FROM `Chars` WHERE (chr > '2')
+-----+
| chr |
+-----+
| 222 |
| 3   |
+-----+
2 rows in set
```

## list 2-25. 仕入単価が 2800 でないの行を選択

```
> Shohin.where.not(shiire_tanka: 2800)
  Shohin Load (0.4ms)  SELECT `Shohin`.* FROM `Shohin` WHERE (`Shohin`.`shiire_tanka` != 2800)
+-----------+--------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei   | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+--------------+---------------+--------------+--------------+------------+
| 0001      | Tシャツ      | 衣服          | 1000         | 500          | 2009-09-20 |
| 0002      | 穴あけパンチ | 事務用品      | 500          | 320          | 2009-09-11 |
| 0005      | 圧力鍋       | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 0007      | おろしがね   | キッチン用品  | 880          | 790          | 2008-04-28 |
+-----------+--------------+---------------+--------------+--------------+------------+
4 rows in set
```

## list 2-27. 間違っている SELECT

```
> Shohin.where('shiire_tanka=NULL')
  Shohin Load (59.4ms)  SELECT `Shohin`.* FROM `Shohin` WHERE (shiire_tanka=NULL)
=> []
```

## list 2-28. NULL の行を選択

```
> Shohin.where(shiire_tanka: nil)
  Shohin Load (0.5ms)  SELECT `Shohin`.* FROM `Shohin` WHERE `Shohin`.`shiire_tanka` IS NULL
+-----------+------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+------------+---------------+--------------+--------------+------------+
| 0006      | フォーク   | キッチン用品  | 500          |              | 2009-09-20 |
| 0008      | ボールペン | 事務用品      | 100          |              | 2009-11-11 |
+-----------+------------+---------------+--------------+--------------+------------+
2 rows in set
```

## list 2-29. NULL でない行を選択

```
> Shohin.where.not(shiire_tanka: nil)
  Shohin Load (0.5ms)  SELECT `Shohin`.* FROM `Shohin` WHERE (`Shohin`.`shiire_tanka` IS NOT NULL)
+-----------+----------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei     | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+----------------+---------------+--------------+--------------+------------+
| 0001      | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 0002      | 穴あけパンチ   | 事務用品      | 500          | 320          | 2009-09-11 |
| 0003      | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 0004      | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 0005      | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 0007      | おろしがね     | キッチン用品  | 880          | 790          | 2008-04-28 |
+-----------+----------------+---------------+--------------+--------------+------------+
6 rows in set
```

## list 2-30. 販売単価が 1000 以上を選択

```
> Shohin.where('hanbai_tanka>=?', 1000)
  Shohin Load (51.6ms)  SELECT `Shohin`.* FROM `Shohin` WHERE (hanbai_tanka>=1000)
+-----------+----------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei     | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+----------------+---------------+--------------+--------------+------------+
| 0001      | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 0003      | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 0004      | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 0005      | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
+-----------+----------------+---------------+--------------+--------------+------------+
4 rows in set
```

## list 2-31. not を指定

```
> Shohin.where.not('hanbai_tanka>=?', 1000)
  Shohin Load (33.7ms)  SELECT `Shohin`.* FROM `Shohin` WHERE (NOT (hanbai_tanka>=1000))
+-----------+--------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei   | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+--------------+---------------+--------------+--------------+------------+
| 0002      | 穴あけパンチ | 事務用品      | 500          | 320          | 2009-09-11 |
| 0006      | フォーク     | キッチン用品  | 500          |              | 2009-09-20 |
| 0007      | おろしがね   | キッチン用品  | 880          | 790          | 2008-04-28 |
| 0008      | ボールペン   | 事務用品      | 100          |              | 2009-11-11 |
+-----------+--------------+---------------+--------------+--------------+------------+
4 rows in set
```

## list 2-32. 2-31 と同じ

```
> Shohin.where('hanbai_tanka<?', 1000)
  Shohin Load (0.5ms)  SELECT `Shohin`.* FROM `Shohin` WHERE (hanbai_tanka<1000)
+-----------+--------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei   | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+--------------+---------------+--------------+--------------+------------+
| 0002      | 穴あけパンチ | 事務用品      | 500          | 320          | 2009-09-11 |
| 0006      | フォーク     | キッチン用品  | 500          |              | 2009-09-20 |
| 0007      | おろしがね   | キッチン用品  | 880          | 790          | 2008-04-28 |
| 0008      | ボールペン   | 事務用品      | 100          |              | 2009-11-11 |
+-----------+--------------+---------------+--------------+--------------+------------+
4 rows in set
```

## list 2-33. where に and を使う

```
> Shohin.where('hanbai_tanka > ?', 3000).where(shohin_bunrui: 'キッチン用品')
  Shohin Load (0.5ms)  SELECT `Shohin`.* FROM `Shohin` WHERE (hanbai_tanka > 3000) AND `Shohin`.`shohin_bunrui` = 'キッチン用品'
+-----------+------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+------------+---------------+--------------+--------------+------------+
| 0005      | 圧力鍋     | キッチン用品  | 6800         | 5000         | 2009-01-15 |
+-----------+------------+---------------+--------------+--------------+------------+
1 row in set
```

## list 2-34. where に or を使う

```
> Shohin.where('hanbai_tanka > ?', 3000).or(Shohin.where(shohin_bunrui: 'キッチン用品'))
  Shohin Load (0.9ms)  SELECT `Shohin`.* FROM `Shohin` WHERE ((hanbai_tanka > 3000) OR `Shohin`.`shohin_bunrui` = 'キッチン用品')
+-----------+----------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei     | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+----------------+---------------+--------------+--------------+------------+
| 0003      | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 0004      | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 0005      | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 0006      | フォーク       | キッチン用品  | 500          |              | 2009-09-20 |
| 0007      | おろしがね     | キッチン用品  | 880          | 790          | 2008-04-28 |
+-----------+----------------+---------------+--------------+--------------+------------+
5 rows in set
```

## list 2-35.

## list 2-36.

```
> Shohin.find_by_sql('select * from Shohin where shohin_bunrui="事務用品" and (torokubi="2009-09-11" or torokubi="2009-09-20")')
  Shohin Load (0.5ms)  select * from Shohin where shohin_bunrui="事務用品" and (torokubi="2009-09-11" or torokubi="2009-09-20")
+-----------+--------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei   | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+--------------+---------------+--------------+--------------+------------+
| 0002      | 穴あけパンチ | 事務用品      | 500          | 320          | 2009-09-11 |
+-----------+--------------+---------------+--------------+--------------+------------+
1 row in set
```

## list 3-1. 全行を数える

```
> Shohin.count
   (31.6ms)  SELECT COUNT(*) FROM `Shohin`
=> 8
```

## list 3-2. NULL を除外して数える

```
> Shohin.count(:shiire_tanka)
   (0.9ms)  SELECT COUNT(`Shohin`.`shiire_tanka`) FROM `Shohin`
=> 6
```

## list 3-3. NULLを含む列を引数にすると count(＊) と count(列名)の結果は異なる

## list 3-4. 販売単価の合計

```
> Shohin.sum(:hanbai_tanka)
   (0.6ms)  SELECT SUM(`Shohin`.`hanbai_tanka`) FROM `Shohin`
=> 16780
```

## list 3-5. 販売単価と仕入単価の合計

```
> Shohin.select('sum(hanbai_tanka)', 'sum(shiire_tanka)')
  Shohin Load (3.0ms)  SELECT sum(hanbai_tanka), sum(shiire_tanka) FROM `Shohin`
+-----------+-------------------+-------------------+
| shohin_id | sum(hanbai_tanka) | sum(shiire_tanka) |
+-----------+-------------------+-------------------+
|           | 16780             | 12210             |
+-----------+-------------------+-------------------+
1 row in set
```

## list 3-6. 販売単価の平均

```
> Shohin.average(:hanbai_tanka)
   (52.6ms)  SELECT AVG(`Shohin`.`hanbai_tanka`) FROM `Shohin`
=> 0.20975e4

> Shohin.average(:hanbai_tanka).to_i
   (0.5ms)  SELECT AVG(`Shohin`.`hanbai_tanka`) FROM `Shohin`
=> 2097
```

## list 3-7. 販売単価と仕入れ単価の平均

```
> Shohin.select('avg(hanbai_tanka)', 'avg(shiire_tanka)')
  Shohin Load (0.6ms)  SELECT avg(hanbai_tanka), avg(shiire_tanka) FROM `Shohin`
+-----------+-------------------+-------------------+
| shohin_id | avg(hanbai_tanka) | avg(shiire_tanka) |
+-----------+-------------------+-------------------+
|           | 2097.5            | 2035.0            |
+-----------+-------------------+-------------------+
1 row in set
```

## list 3-8. 販売単価の最大、仕入単価の最小

```
> Shohin.select('max(hanbai_tanka)', 'min(shiire_tanka)')
  Shohin Load (0.5ms)  SELECT max(hanbai_tanka), min(shiire_tanka) FROM `Shohin`
+-----------+-------------------+-------------------+
| shohin_id | max(hanbai_tanka) | min(shiire_tanka) |
+-----------+-------------------+-------------------+
|           | 6800              | 320               |
+-----------+-------------------+-------------------+
1 row in set
```

## list 3-9. 登録日の最大、最小

```
> Shohin.select('max(torokubi)', 'min(torokubi)')
  Shohin Load (0.6ms)  SELECT max(torokubi), min(torokubi) FROM `Shohin`
+-----------+---------------+---------------+
| shohin_id | max(torokubi) | min(torokubi) |
+-----------+---------------+---------------+
|           | 2009-11-11    | 2008-04-28    |
+-----------+---------------+---------------+
1 row in set
```

## list 3-10. 値の重複をのぞいて行数を数える

```
> Shohin.distinct.count(:shohin_bunrui)
   (32.0ms)  SELECT COUNT(DISTINCT `Shohin`.`shohin_bunrui`) FROM `Shohin`
=> 3

> Shohin.select(:shohin_bunrui).distinct.count
   (0.5ms)  SELECT COUNT(DISTINCT `Shohin`.`shohin_bunrui`) FROM `Shohin`
=> 3
```

## list 3-11.

## list 3-12. DISTINCT の有無での SUM の違い

```
> Shohin.distinct(:hanbai_tanka).sum(:hanbai_tanka)
   (0.5ms)  SELECT SUM(DISTINCT `Shohin`.`hanbai_tanka`) FROM `Shohin`
=> 16280

> Shohin.sum(:hanbai_tanka)
   (0.4ms)  SELECT SUM(`Shohin`.`hanbai_tanka`) FROM `Shohin`
=> 16780

> Shohin.select('sum(hanbai_tanka)', 'sum(DISTINCT hanbai_tanka)')
  Shohin Load (0.5ms)  SELECT sum(hanbai_tanka), sum(DISTINCT hanbai_tanka) FROM `Shohin`
+-----------+-------------------+----------------------------+
| shohin_id | sum(hanbai_tanka) | sum(DISTINCT hanbai_tanka) |
+-----------+-------------------+----------------------------+
|           | 16780             | 16280                      |
+-----------+-------------------+----------------------------+
1 row in set
```

## list 3-13. 商品分類ごとの数

```
> Shohin.group(:shohin_bunrui).count
   (52.2ms)  SELECT COUNT(*) AS count_all, `Shohin`.`shohin_bunrui` AS shohin_shohin_bunrui FROM `Shohin` GROUP BY `Shohin`.`shohin_bunrui`
=> {"キッチン用品"=>4, "事務用品"=>2, "衣服"=>2}
```

```
> Shohin.group(:shohin_bunrui).select(:shohin_bunrui, 'count(*)')
  Shohin Load (0.8ms)  SELECT `Shohin`.`shohin_bunrui`, count(*) FROM `Shohin` GROUP BY `Shohin`.`shohin_bunrui`
+-----------+---------------+----------+
| shohin_id | shohin_bunrui | count(*) |
+-----------+---------------+----------+
|           | キッチン用品  | 4        |
|           | 事務用品      | 2        |
|           | 衣服          | 2        |
+-----------+---------------+----------+
3 rows in set
```

## list 3-14. 仕入れ単価ごとの行数

```
> Shohin.group(:shiire_tanka).count
   (0.6ms)  SELECT COUNT(*) AS count_all, `Shohin`.`shiire_tanka` AS shohin_shiire_tanka FROM `Shohin` GROUP BY `Shohin`.`shiire_tanka`
=> {nil=>2, 320=>1, 500=>1, 790=>1, 2800=>2, 5000=>1}

> Shohin.group(:shiire_tanka).select(:shiire_tanka, 'count(*)')
  Shohin Load (0.6ms)  SELECT `Shohin`.`shiire_tanka`, count(*) FROM `Shohin` GROUP BY `Shohin`.`shiire_tanka`
+-----------+--------------+----------+
| shohin_id | shiire_tanka | count(*) |
+-----------+--------------+----------+
|           |              | 2        |
|           | 320          | 1        |
|           | 500          | 1        |
|           | 790          | 1        |
|           | 2800         | 2        |
|           | 5000         | 1        |
+-----------+--------------+----------+
6 rows in set
```

## list 3-15. where と group の併用

```
> Shohin.where(shohin_bunrui: '衣服').group(:shiire_tanka).select(:shiire_tanka, 'count(*)')
  Shohin Load (0.6ms)  SELECT `Shohin`.`shiire_tanka`, count(*) FROM `Shohin` WHERE `Shohin`.`shohin_bunrui` = '衣服' GROUP BY `Shohin`.`shiire_tanka`
+-----------+--------------+----------+
| shohin_id | shiire_tanka | count(*) |
+-----------+--------------+----------+
|           | 500          | 1        |
|           | 2800         | 1        |
+-----------+--------------+----------+
2 rows in set


```

## list 3-16.

## list 3-17.

## list 3-18. 商品分類ごとに行数を数える

```
> Shohin.group(:shohin_bunrui).select(:shohin_bunrui, 'count(*)')
  Shohin Load (0.6ms)  SELECT `Shohin`.`shohin_bunrui`, count(*) FROM `Shohin` GROUP BY `Shohin`.`shohin_bunrui`
+-----------+---------------+----------+
| shohin_id | shohin_bunrui | count(*) |
+-----------+---------------+----------+
|           | キッチン用品  | 4        |
|           | 事務用品      | 2        |
|           | 衣服          | 2        |
+-----------+---------------+----------+
3 rows in set
```

## list 3-19.

## list 3-A. DISTINCT と GROUP BY の動作

```
> Shohin.select(:shohin_bunrui).distinct
  Shohin Load (0.4ms)  SELECT DISTINCT `Shohin`.`shohin_bunrui` FROM `Shohin`
+-----------+---------------+
| shohin_id | shohin_bunrui |
+-----------+---------------+
|           | 衣服          |
|           | 事務用品      |
|           | キッチン用品  |
+-----------+---------------+
3 rows in set

> Shohin.group(:shohin_bunrui).select(:shohin_bunrui)
  Shohin Load (59.0ms)  SELECT `Shohin`.`shohin_bunrui` FROM `Shohin` GROUP BY `Shohin`.`shohin_bunrui`
+-----------+---------------+
| shohin_id | shohin_bunrui |
+-----------+---------------+
|           | キッチン用品  |
|           | 事務用品      |
|           | 衣服          |
+-----------+---------------+
3 rows in set
```

## list 3-20. 商品分類で集約したグループから「 含まれる行数が2 行」のものを選択する

```
> Shohin.group(:shohin_bunrui).select('count(*)', :shohin_bunrui).having('count(*)=2')
  Shohin Load (0.6ms)  SELECT count(*), `Shohin`.`shohin_bunrui` FROM `Shohin` GROUP BY `Shohin`.`shohin_bunrui` HAVING (count(*)=2)
+-----------+---------------+----------+
| shohin_id | shohin_bunrui | count(*) |
+-----------+---------------+----------+
|           | 事務用品      | 2        |
|           | 衣服          | 2        |
+-----------+---------------+----------+
2 rows in set
```

## list 3-22. having を指定しなかった場合

```
> Shohin.group(:shohin_bunrui).select('count(*)', :shohin_bunrui)
  Shohin Load (0.5ms)  SELECT count(*), `Shohin`.`shohin_bunrui` FROM `Shohin` GROUP BY `Shohin`.`shohin_bunrui`
+-----------+---------------+----------+
| shohin_id | shohin_bunrui | count(*) |
+-----------+---------------+----------+
|           | キッチン用品  | 4        |
|           | 事務用品      | 2        |
|           | 衣服          | 2        |
+-----------+---------------+----------+
3 rows in set
```

## list 3-23. having を指定した場合

```
> Shohin.group(:shohin_bunrui).select(:shohin_bunrui, 'avg(hanbai_tanka)').having('avg(hanbai_tanka) >= ?', 2500)
  Shohin Load (1.2ms)  SELECT `Shohin`.`shohin_bunrui`, avg(hanbai_tanka) FROM `Shohin` GROUP BY `Shohin`.`shohin_bunrui` HAVING (avg(hanbai_tanka) >= 2500)
+-----------+---------------+-------------------+
| shohin_id | shohin_bunrui | avg(hanbai_tanka) |
+-----------+---------------+-------------------+
|           | キッチン用品  | 2795.0            |
|           | 衣服          | 2500.0            |
+-----------+---------------+-------------------+
2 rows in set
```

## list 3-24.

## list 3-25. 条件を WEHER 句に書いた場合

```
> Shohin.group(:shohin_bunrui).having(shohin_bunrui: '衣服').select(:shohin_bunrui, 'count(*)')
  Shohin Load (0.8ms)  SELECT `Shohin`.`shohin_bunrui`, count(*) FROM `Shohin` GROUP BY `Shohin`.`shohin_bunrui` HAVING `Shohin`.`shohin_bunrui` = '衣服'
+-----------+---------------+----------+
| shohin_id | shohin_bunrui | count(*) |
+-----------+---------------+----------+
|           | 衣服          | 2        |
+-----------+---------------+----------+
1 row in set
```

## list 3-26. 条件を WEHER 句に書いた場合

```
> Shohin.group(:shohin_bunrui).where(shohin_bunrui: '衣服').select(:shohin_bunrui, 'count(*)')
  Shohin Load (0.6ms)  SELECT `Shohin`.`shohin_bunrui`, count(*) FROM `Shohin` WHERE `Shohin`.`shohin_bunrui` = '衣服' GROUP BY `Shohin`.`shohin_bunrui`
+-----------+---------------+----------+
| shohin_id | shohin_bunrui | count(*) |
+-----------+---------------+----------+
|           | 衣服          | 2        |
+-----------+---------------+----------+
1 row in set
```

## list 3.27. 商品ID、 商品名、 販売単価、 仕入単価を表示する

```
> Shohin.select(:shohin_id, :shohin_mei, :hanbai_tanka, :shiire_tanka)
  Shohin Load (0.5ms)  SELECT `Shohin`.`shohin_id`, `Shohin`.`shohin_mei`, `Shohin`.`hanbai_tanka`, `Shohin`.`shiire_tanka` FROM `Shohin`
+-----------+----------------+--------------+--------------+
| shohin_id | shohin_mei     | hanbai_tanka | shiire_tanka |
+-----------+----------------+--------------+--------------+
| 0001      | Tシャツ        | 1000         | 500          |
| 0002      | 穴あけパンチ   | 500          | 320          |
| 0003      | カッターシャツ | 4000         | 2800         |
| 0004      | 包丁           | 3000         | 2800         |
| 0005      | 圧力鍋         | 6800         | 5000         |
| 0006      | フォーク       | 500          |              |
| 0007      | おろしがね     | 880          | 790          |
| 0008      | ボールペン     | 100          |              |
+-----------+----------------+--------------+--------------+
8 rows in set
```

## list 3-28. 販売単価の低い順（昇順）に並べる

```
> Shohin.select(:shohin_id, :shohin_mei, :hanbai_tanka, :shiire_tanka).order(hanbai_tanka: :asc)
  Shohin Load (0.7ms)  SELECT `Shohin`.`shohin_id`, `Shohin`.`shohin_mei`, `Shohin`.`hanbai_tanka`, `Shohin`.`shiire_tanka` FROM `Shohin` ORDER BY `Shohin`.`hanbai_tanka` ASC
+-----------+----------------+--------------+--------------+
| shohin_id | shohin_mei     | hanbai_tanka | shiire_tanka |
+-----------+----------------+--------------+--------------+
| 0008      | ボールペン     | 100          |              |
| 0002      | 穴あけパンチ   | 500          | 320          |
| 0006      | フォーク       | 500          |              |
| 0007      | おろしがね     | 880          | 790          |
| 0001      | Tシャツ        | 1000         | 500          |
| 0004      | 包丁           | 3000         | 2800         |
| 0003      | カッターシャツ | 4000         | 2800         |
| 0005      | 圧力鍋         | 6800         | 5000         |
+-----------+----------------+--------------+--------------+
8 rows in set
```


## list 3-28. 販売単価の高いい順（降順）に並べる

```
> Shohin.select(:shohin_id, :shohin_mei, :hanbai_tanka, :shiire_tanka).order(hanbai_tanka: :desc)
  Shohin Load (2.6ms)  SELECT `Shohin`.`shohin_id`, `Shohin`.`shohin_mei`, `Shohin`.`hanbai_tanka`, `Shohin`.`shiire_tanka` FROM `Shohin` ORDER BY `Shohin`.`hanbai_tanka` DESC
+-----------+----------------+--------------+--------------+
| shohin_id | shohin_mei     | hanbai_tanka | shiire_tanka |
+-----------+----------------+--------------+--------------+
| 0005      | 圧力鍋         | 6800         | 5000         |
| 0003      | カッターシャツ | 4000         | 2800         |
| 0004      | 包丁           | 3000         | 2800         |
| 0001      | Tシャツ        | 1000         | 500          |
| 0007      | おろしがね     | 880          | 790          |
| 0002      | 穴あけパンチ   | 500          | 320          |
| 0006      | フォーク       | 500          |              |
| 0008      | ボールペン     | 100          |              |
+-----------+----------------+--------------+--------------+
8 rows in set
```

## list 3-30. 販売単価と商品IDの昇順に並べる

```
> Shohin.select(:shohin_id, :shohin_mei, :hanbai_tanka, :shiire_tanka).order(hanbai_tanka: :asc, shohin_id: :asc)
  Shohin Load (0.6ms)  SELECT `Shohin`.`shohin_id`, `Shohin`.`shohin_mei`, `Shohin`.`hanbai_tanka`, `Shohin`.`shiire_tanka` FROM `Shohin` ORDER BY `Shohin`.`hanbai_tanka` ASC, `Shohin`.`shohin_id` ASC
+-----------+----------------+--------------+--------------+
| shohin_id | shohin_mei     | hanbai_tanka | shiire_tanka |
+-----------+----------------+--------------+--------------+
| 0008      | ボールペン     | 100          |              |
| 0002      | 穴あけパンチ   | 500          | 320          |
| 0006      | フォーク       | 500          |              |
| 0007      | おろしがね     | 880          | 790          |
| 0001      | Tシャツ        | 1000         | 500          |
| 0004      | 包丁           | 3000         | 2800         |
| 0003      | カッターシャツ | 4000         | 2800         |
| 0005      | 圧力鍋         | 6800         | 5000         |
+-----------+----------------+--------------+--------------+
8 rows in set
```

## list 3-31. 仕入単価の昇順に並べる

```
> Shohin.select(:shohin_id, :shohin_mei, :hanbai_tanka, :shiire_tanka).order(shiire_tanka: :asc)
  Shohin Load (0.6ms)  SELECT `Shohin`.`shohin_id`, `Shohin`.`shohin_mei`, `Shohin`.`hanbai_tanka`, `Shohin`.`shiire_tanka` FROM `Shohin` ORDER BY `Shohin`.`shiire_tanka` ASC
+-----------+----------------+--------------+--------------+
| shohin_id | shohin_mei     | hanbai_tanka | shiire_tanka |
+-----------+----------------+--------------+--------------+
| 0006      | フォーク       | 500          |              |
| 0008      | ボールペン     | 100          |              |
| 0002      | 穴あけパンチ   | 500          | 320          |
| 0001      | Tシャツ        | 1000         | 500          |
| 0007      | おろしがね     | 880          | 790          |
| 0003      | カッターシャツ | 4000         | 2800         |
| 0004      | 包丁           | 3000         | 2800         |
| 0005      | 圧力鍋         | 6800         | 5000         |
+-----------+----------------+--------------+--------------+
8 rows in set
```


## list 3-32. ORDER BY 句では列の別名が使える

```
> Shohin.select('shohin_id, shohin_mei, hanbai_tanka AS ht, shiire_tanka').order('ht, shohin_id')
  Shohin Load (0.5ms)  SELECT shohin_id, shohin_mei, hanbai_tanka AS ht, shiire_tanka FROM `Shohin` ORDER BY ht, shohin_id
+-----------+----------------+--------------+------+
| shohin_id | shohin_mei     | shiire_tanka | ht   |
+-----------+----------------+--------------+------+
| 0008      | ボールペン     |              | 100  |
| 0002      | 穴あけパンチ   | 320          | 500  |
| 0006      | フォーク       |              | 500  |
| 0007      | おろしがね     | 790          | 880  |
| 0001      | Tシャツ        | 500          | 1000 |
| 0004      | 包丁           | 2800         | 3000 |
| 0003      | カッターシャツ | 2800         | 4000 |
| 0005      | 圧力鍋         | 5000         | 6800 |
+-----------+----------------+--------------+------+
8 rows in set
```

## list 3-33. SELECT 句に含まれていない列も ORDER RY 句に指定できる

```
> Shohin.select(:shohin_mei, :hanbai_tanka, :shiire_tanka).order(shohin_id: :asc)
  Shohin Load (3.1ms)  SELECT `Shohin`.`shohin_mei`, `Shohin`.`hanbai_tanka`, `Shohin`.`shiire_tanka` FROM `Shohin` ORDER BY `Shohin`.`shohin_id` ASC
+-----------+----------------+--------------+--------------+
| shohin_id | shohin_mei     | hanbai_tanka | shiire_tanka |
+-----------+----------------+--------------+--------------+
|           | Tシャツ        | 1000         | 500          |
|           | 穴あけパンチ   | 500          | 320          |
|           | カッターシャツ | 4000         | 2800         |
|           | 包丁           | 3000         | 2800         |
|           | 圧力鍋         | 6800         | 5000         |
|           | フォーク       | 500          |              |
|           | おろしがね     | 880          | 790          |
|           | ボールペン     | 100          |              |
+-----------+----------------+--------------+--------------+
8 rows in set
```

## list 3-34. 集約関数も ORDER BY句で利用可能

```
> Shohin.group(:shohin_bunrui).select(:shohin_bunrui, 'count(*)').order('count(*) desc')
  Shohin Load (0.8ms)  SELECT `Shohin`.`shohin_bunrui`, count(*) FROM `Shohin` GROUP BY `Shohin`.`shohin_bunrui` ORDER BY count(*) desc
+-----------+---------------+----------+
| shohin_id | shohin_bunrui | count(*) |
+-----------+---------------+----------+
|           | キッチン用品  | 4        |
|           | 衣服          | 2        |
|           | 事務用品      | 2        |
+-----------+---------------+----------+
3 rows in set
```

## list 3-35. ORDER BY 句では列番号を指定できる

```
> Shohin.group(:shohin_bunrui).select(:shohin_bunrui, 'count(*)').order('3 desc, 1')
  Shohin Load (0.9ms)  SELECT `Shohin`.`shohin_bunrui`, count(*) FROM `Shohin` GROUP BY `Shohin`.`shohin_bunrui` ORDER BY 3 desc, 1
Hirb Error: Mysql2::Error: Unknown column '3' in 'order clause': SELECT `Shohin`.`shohin_bunrui`, count(*) FROM `Shohin` GROUP BY `Shohin`.`shohin_bunrui` ORDER BY 3 desc, 1
```

## list 4-1.

## list 4-2.

## list 4-3.

## list 4-4.

## list 4-5.

## list 4-6.

## list 4-7.

## list 4-8.

## list 4-9.

## list 4-10.

## list 4-11.

## list 4-12.

## list 4-13.

## list 4-14.

## list 4-15.

## list 4-16.

## list 4-17.

## list 4-18.

## list 4-19.

## list 4-20.

## list 4-21.

## list 4-22.

## list 5-1. ビューなら SELECT 文だけを保存すれば良い

```
> Shohin.group(:shohin_bunrui).select(:shohin_bunrui, 'sum(hanbai_tanka)', 'sum(shiire_tanka)')
  Shohin Load (0.6ms)  SELECT `Shohin`.`shohin_bunrui`, sum(hanbai_tanka), sum(shiire_tanka) FROM `Shohin` GROUP BY `Shohin`.`shohin_bunrui`
+-----------+---------------+-------------------+-------------------+
| shohin_id | shohin_bunrui | sum(hanbai_tanka) | sum(shiire_tanka) |
+-----------+---------------+-------------------+-------------------+
|           | キッチン用品  | 11180             | 8590              |
|           | 事務用品      | 600               | 320               |
|           | 衣服          | 5000              | 3300              |
+-----------+---------------+-------------------+-------------------+
3 rows in set
```

## list 5-2. ShohinSum ビュー

```
マイグレーションで作成
def self.up
  execute <<-SQL
    CREATE VIEW ShohinSum (shohin_bunrui, count_shohin)
    AS
    SELECT shohin_bunrui, count(*)
    FROM Shohin
    GROUP BY shohin_bunrui;
  SQL
end
```

## list 5-3. ビューを使う

```
> ShohinSum.select(:shohin_bunrui, :count_shohin)
  ShohinSum Load (61.7ms)  SELECT `ShohinSum`.`shohin_bunrui`, `ShohinSum`.`count_shohin` FROM `ShohinSum`
+---------------+--------------+
| shohin_bunrui | count_shohin |
+---------------+--------------+
| キッチン用品  | 4            |
| 事務用品      | 2            |
| 衣服          | 2            |
+---------------+--------------+
3 rows in set
```

## list 5-4. ShohinSumJim ビュー

```
execute <<-SQL
  CREATE VIEW ShohinSumJim (shohin_bunrui, count_shohin)
  AS
  SELECT shohin_bunrui, count(*)
  FROM ShohinSum
  WHERE shohin_bunrui = '事務用品'
SQL
```

## list 5-5.

## list 5-6.

## list 5-7. ビューの削除

```
def self.down
  execute <<-SQL
    DROP VIEW ShohinSum;
  SQL
end
```

## list 5-8.

## list 5-9.

## list 5-10.

TODO

## list 5-11. 平均の販売単価を求めるスカラ・サブクエリ

```
> Shohin.average(:hanbai_tanka)
   (2.3ms)  SELECT AVG(`Shohin`.`hanbai_tanka`) FROM `Shohin`
=> 0.20975e4
```

## list 5-12. 販売単価（hanbai_ tanka）が商品すべての販売単価平均より高い商品

```
> Shohin.where("hanbai_tanka > ?", Shohin.average(:hanbai_tanka)).select(:shohin_id, :shohin_mei, :hanbai_tanka)
   (0.5ms)  SELECT AVG(`Shohin`.`hanbai_tanka`) FROM `Shohin`
  Shohin Load (0.7ms)  SELECT `Shohin`.`shohin_id`, `Shohin`.`shohin_mei`, `Shohin`.`hanbai_tanka` FROM `Shohin` WHERE (hanbai_tanka > 2097.5)
+-----------+----------------+--------------+
| shohin_id | shohin_mei     | hanbai_tanka |
+-----------+----------------+--------------+
| 0003      | カッターシャツ | 4000         |
| 0004      | 包丁           | 3000         |
| 0005      | 圧力鍋         | 6800         |
+-----------+----------------+--------------+
3 rows in set
```

## list 5-13. SELECT 句 で スカラ・サブクエリ を 使う

```
> Shohin.select(
   'shohin_id, shohin_mei, hanbai_tanka,  
   (SELECT AVG(hanbai_tanka) FROM Shohin) AS avg_tanka')
   Shohin Load (0.5ms)  SELECT shohin_id, shohin_mei, hanbai_tanka,  
    (SELECT AVG(hanbai_tanka) FROM Shohin) AS avg_tanka FROM `Shohin`
 +-----------+----------------+--------------+-----------+
 | shohin_id | shohin_mei     | hanbai_tanka | avg_tanka |
 +-----------+----------------+--------------+-----------+
 | 0001      | Tシャツ        | 1000         | 2097.5    |
 | 0002      | 穴あけパンチ   | 500          | 2097.5    |
 | 0003      | カッターシャツ | 4000         | 2097.5    |
 | 0004      | 包丁           | 3000         | 2097.5    |
 | 0005      | 圧力鍋         | 6800         | 2097.5    |
 | 0006      | フォーク       | 500          | 2097.5    |
 | 0007      | おろしがね     | 880          | 2097.5    |
 | 0008      | ボールペン     | 100          | 2097.5    |
 +-----------+----------------+--------------+-----------+
 8 rows in set
```

## list 5-14. HAVING句でスカラ・サブクエリを使う

```
Shohin.group(:shohin_bunrui).having('avg(hanbai_tanka) > (Select AVG(hanbai_tanka) FROM Shohin)').select(:shohin_bunrui, 'AVG(hanbai_tanka)')
Shohin Load (1.4ms)  SELECT `Shohin`.`shohin_bunrui`, AVG(hanbai_tanka) FROM `Shohin` GROUP BY `Shohin`.`shohin_bunrui` HAVING (avg(hanbai_tanka) > (Select AVG(hanbai_tanka) FROM Shohin))
+-----------+---------------+-------------------+
| shohin_id | shohin_bunrui | AVG(hanbai_tanka) |
+-----------+---------------+-------------------+
|           | キッチン用品  | 2795.0            |
|           | 衣服          | 2500.0            |
+-----------+---------------+-------------------+
2 rows in set
```

## list 5-15. 商品分類別に平均価格を求める

```
)> Shohin.group(:shohin_bunrui).select('shohin_bunrui, avg(hanbai_tanka)')
  Shohin Load (0.7ms)  SELECT shohin_bunrui, avg(hanbai_tanka) FROM `Shohin` GROUP BY `Shohin`.`shohin_bunrui`
+-----------+---------------+-------------------+
| shohin_id | shohin_bunrui | avg(hanbai_tanka) |
+-----------+---------------+-------------------+
|           | キッチン用品  | 2795.0            |
|           | 事務用品      | 300.0             |
|           | 衣服          | 2500.0            |
+-----------+---------------+-------------------+
3 rows in set

> Shohin.group(:shohin_bunrui).average(:hanbai_tanka)
   (0.8ms)  SELECT AVG(`Shohin`.`hanbai_tanka`) AS average_hanbai_tanka, `Shohin`.`shohin_bunrui` AS shohin_shohin_bunrui FROM `Shohin` GROUP BY `Shohin`.`shohin_bunrui`
=> {"キッチン用品"=>0.2795e4, "事務用品"=>0.3e3, "衣服"=>0.25e4}
```

## list 5-16. 相関サブクエリで商品分類ごとに平均販売単価と比較する

TODO

## list 6-＊.

## list 7-1.

## list 7-2.

## list 7-3. UNION による テーブル の 足し算

```
> Shohin.find_by_sql('SELECT shohin_id, shohin_mei FROM Shohin UNION SELECT shohin_id, shohin_mei FROM Shohin2')
  Shohin Load (52.3ms)  SELECT shohin_id, shohin_mei FROM Shohin UNION SELECT shohin_id, shohin_mei FROM Shohin2
+-----------+----------------+
| shohin_id | shohin_mei     |
+-----------+----------------+
| 0001      | Tシャツ        |
| 0002      | 穴あけパンチ   |
| 0003      | カッターシャツ |
| 0004      | 包丁           |
| 0005      | 圧力鍋         |
| 0006      | フォーク       |
| 0007      | おろしがね     |
| 0008      | ボールペン     |
| 0009      | 手袋           |
| 0010      | やかん         |
+-----------+----------------+
10 rows in set
```

## list 7-5. 重複行を排除しない

```
> Shohin.find_by_sql('SELECT shohin_id, shohin_mei FROM Shohin UNION ALL SELECT shohin_id, shohin_mei FROM Shohin2')
  Shohin Load (0.6ms)  SELECT shohin_id, shohin_mei FROM Shohin UNION ALL SELECT shohin_id, shohin_mei FROM Shohin2
+-----------+----------------+
| shohin_id | shohin_mei     |
+-----------+----------------+
| 0001      | Tシャツ        |
| 0002      | 穴あけパンチ   |
| 0003      | カッターシャツ |
| 0004      | 包丁           |
| 0005      | 圧力鍋         |
| 0006      | フォーク       |
| 0007      | おろしがね     |
| 0008      | ボールペン     |
| 0001      | Tシャツ        |
| 0002      | 穴あけパンチ   |
| 0003      | カッターシャツ |
| 0009      | 手袋           |
| 0010      | やかん         |
+-----------+----------------+
13 rows in set
```

## list 7-6. INTERSECTによるテーブル共通部分の選択

## list 7-7. EXCEPTによるレコードの引き算

## list 7-8. どちらからどちらを引くかで結果が異なる

## list 7-9. 2つのテーブルを内部結合する

```
> TenpoShohin.joins(:shohin).select(:tenpo_id, :tenpo_mei, :shohin_id, :shohin_mei, :hanbai_tanka)
  TenpoShohin Load (0.6ms)  SELECT `TenpoShohin`.`tenpo_id`, `TenpoShohin`.`tenpo_mei`, `TenpoShohin`.`shohin_id`, `shohin_mei`, `hanbai_tanka` FROM `TenpoShohin` INNER JOIN `Shohin` ON `Shohin`.`shohin_id` = `TenpoShohin`.`shohin_id`
+----------+-----------+-----------+----------------+--------------+
| tenpo_id | tenpo_mei | shohin_id | shohin_mei     | hanbai_tanka |
+----------+-----------+-----------+----------------+--------------+
| 000A     | 東京      | 0001      | Tシャツ        | 1000         |
| 000A     | 東京      | 0002      | 穴あけパンチ   | 500          |
| 000A     | 東京      | 0003      | カッターシャツ | 4000         |
| 000B     | 名古屋    | 0002      | 穴あけパンチ   | 500          |
| 000B     | 名古屋    | 0003      | カッターシャツ | 4000         |
| 000B     | 名古屋    | 0004      | 包丁           | 3000         |
| 000B     | 名古屋    | 0006      | フォーク       | 500          |
| 000B     | 名古屋    | 0007      | おろしがね     | 880          |
| 000C     | 大阪      | 0003      | カッターシャツ | 4000         |
| 000C     | 大阪      | 0004      | 包丁           | 3000         |
| 000C     | 大阪      | 0006      | フォーク       | 500          |
| 000C     | 大阪      | 0007      | おろしがね     | 880          |
| 000D     | 福岡      | 0001      | Tシャツ        | 1000         |
+----------+-----------+-----------+----------------+--------------+
13 rows in set
```

## list 7-10. 内部結合とWHERE句を組み合わせて使う

```
> TenpoShohin.joins(:shohin).where(tenpo_id: '000A').select(:tenpo_id, :tenpo_mei, :shohin_id, :shohin_mei, :hanbai_tanka)
  TenpoShohin Load (28.3ms)  SELECT `TenpoShohin`.`tenpo_id`, `TenpoShohin`.`tenpo_mei`, `TenpoShohin`.`shohin_id`, `shohin_mei`, `hanbai_tanka` FROM `TenpoShohin` INNER JOIN `Shohin` ON `Shohin`.`shohin_id` = `TenpoShohin`.`shohin_id` WHERE `TenpoShohin`.`tenpo_id` = '000A'
+----------+-----------+-----------+----------------+--------------+
| tenpo_id | tenpo_mei | shohin_id | shohin_mei     | hanbai_tanka |
+----------+-----------+-----------+----------------+--------------+
| 000A     | 東京      | 0001      | Tシャツ        | 1000         |
| 000A     | 東京      | 0002      | 穴あけパンチ   | 500          |
| 000A     | 東京      | 0003      | カッターシャツ | 4000         |
+----------+-----------+-----------+----------------+--------------+
3 rows in set
```

## list 7-11. 2つのテーブルを外部結合する

```
> TenpoShohin.joins("TenpoShohin right outer join Shohin on Shohin.shohin_id=TenpoShohin.shohin_id").select(:tenpo_id, :tenpo_mei, 'Shohin.shohin_id', :shohin_mei, :hanbai_tanka)

  TenpoShohin Load (0.6ms)  SELECT `TenpoShohin`.`tenpo_id`, `TenpoShohin`.`tenpo_mei`, Shohin.shohin_id, `shohin_mei`, `hanbai_tanka` FROM `TenpoShohin` TenpoShohin right outer join Shohin on Shohin.shohin_id=TenpoShohin.shohin_id
+----------+-----------+-----------+----------------+--------------+
| tenpo_id | tenpo_mei | shohin_id | shohin_mei     | hanbai_tanka |
+----------+-----------+-----------+----------------+--------------+
| 000A     | 東京      | 0001      | Tシャツ        | 1000         |
| 000A     | 東京      | 0002      | 穴あけパンチ   | 500          |
| 000A     | 東京      | 0003      | カッターシャツ | 4000         |
| 000B     | 名古屋    | 0002      | 穴あけパンチ   | 500          |
| 000B     | 名古屋    | 0003      | カッターシャツ | 4000         |
| 000B     | 名古屋    | 0004      | 包丁           | 3000         |
| 000B     | 名古屋    | 0006      | フォーク       | 500          |
| 000B     | 名古屋    | 0007      | おろしがね     | 880          |
| 000C     | 大阪      | 0003      | カッターシャツ | 4000         |
| 000C     | 大阪      | 0004      | 包丁           | 3000         |
| 000C     | 大阪      | 0006      | フォーク       | 500          |
| 000C     | 大阪      | 0007      | おろしがね     | 880          |
| 000D     | 福岡      | 0001      | Tシャツ        | 1000         |
|          |           | 0005      | 圧力鍋         | 6800         |
|          |           | 0008      | ボールペン     | 100          |
+----------+-----------+-----------+----------------+--------------+
15 rows in set
```

## list 7-12. テーブルの左右を入れ替えても外部結合の結果は同じ

```
> > Shohin.joins("Shohin left outer join TenpoShohin on Shohin.shohin_id=TenpoShohin.shohin_id").select(:tenpo_id, :tenpo_mei, 'Shohin.shohin_id', :shohin_mei, :hanbai_tanka)

  Shohin Load (0.5ms)  SELECT `tenpo_id`, `tenpo_mei`, Shohin.shohin_id, `Shohin`.`shohin_mei`, `Shohin`.`hanbai_tanka` FROM `Shohin` Shohin left outer join TenpoShohin on Shohin.shohin_id=TenpoShohin.shohin_id
+-----------+----------------+--------------+----------+-----------+
| shohin_id | shohin_mei     | hanbai_tanka | tenpo_id | tenpo_mei |
+-----------+----------------+--------------+----------+-----------+
| 0001      | Tシャツ        | 1000         | 000A     | 東京      |
| 0002      | 穴あけパンチ   | 500          | 000A     | 東京      |
| 0003      | カッターシャツ | 4000         | 000A     | 東京      |
| 0002      | 穴あけパンチ   | 500          | 000B     | 名古屋    |
| 0003      | カッターシャツ | 4000         | 000B     | 名古屋    |
| 0004      | 包丁           | 3000         | 000B     | 名古屋    |
| 0006      | フォーク       | 500          | 000B     | 名古屋    |
| 0007      | おろしがね     | 880          | 000B     | 名古屋    |
| 0003      | カッターシャツ | 4000         | 000C     | 大阪      |
| 0004      | 包丁           | 3000         | 000C     | 大阪      |
| 0006      | フォーク       | 500          | 000C     | 大阪      |
| 0007      | おろしがね     | 880          | 000C     | 大阪      |
| 0001      | Tシャツ        | 1000         | 000D     | 福岡      |
| 0005      | 圧力鍋         | 6800         |          |           |
| 0008      | ボールペン     | 100          |          |           |
+-----------+----------------+--------------+----------+-----------+
15 rows in set

```

## list 7-13.

## list 7-14. 3つのテーブルを内部結合する

```
> TenpoShohin.joins(:shohin => :zaiko_shohins).where(:ZaikoShohin => { souko_id: 'S001'}).select(:tenpo_id, :tenpo_mei, :shohin_id, :shohin_mei)

TenpoShohin Load (0.7ms)  SELECT `TenpoShohin`.`tenpo_id`, `TenpoShohin`.`tenpo_mei`, `TenpoShohin`.`shohin_id`, `shohin_mei` FROM `TenpoShohin` INNER JOIN `Shohin` ON `Shohin`.`shohin_id` = `TenpoShohin`.`shohin_id` INNER JOIN `ZaikoShohin` ON `ZaikoShohin`.`shohin_id` = `Shohin`.`shohin_id` WHERE `ZaikoShohin`.`souko_id` = 'S001'
+----------+-----------+-----------+----------------+
| tenpo_id | tenpo_mei | shohin_id | shohin_mei     |
+----------+-----------+-----------+----------------+
| 000A     | 東京      | 0001      | Tシャツ        |
| 000A     | 東京      | 0002      | 穴あけパンチ   |
| 000A     | 東京      | 0003      | カッターシャツ |
| 000B     | 名古屋    | 0002      | 穴あけパンチ   |
| 000B     | 名古屋    | 0003      | カッターシャツ |
| 000B     | 名古屋    | 0004      | 包丁           |
| 000B     | 名古屋    | 0006      | フォーク       |
| 000B     | 名古屋    | 0007      | おろしがね     |
| 000C     | 大阪      | 0003      | カッターシャツ |
| 000C     | 大阪      | 0004      | 包丁           |
| 000C     | 大阪      | 0006      | フォーク       |
| 000C     | 大阪      | 0007      | おろしがね     |
| 000D     | 福岡      | 0001      | Tシャツ        |
+----------+-----------+-----------+----------------+
13 rows in set
```

## list 7-15. 2 つのテーブルをクロス結合する

```
> TenpoShohin.find_by_sql('select * from TenpoShohin cross join Shohin')
TenpoShohin Load (0.8ms)  select * from TenpoShohin cross join Shohin
+----------+-----------+-----------+-------+----------------+---------------+--------------+--------------+------------+
| tenpo_id | tenpo_mei | shohin_id | suryo | shohin_mei     | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+----------+-----------+-----------+-------+----------------+---------------+--------------+--------------+------------+
| 000A     | 東京      | 0001      | 30    | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 000A     | 東京      | 0002      | 30    | 穴あけパンチ   | 事務用品      | 500          | 320          | 2009-09-11 |
| 000A     | 東京      | 0003      | 30    | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 000A     | 東京      | 0004      | 30    | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 000A     | 東京      | 0005      | 30    | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 000A     | 東京      | 0006      | 30    | フォーク       | キッチン用品  | 500          |              | 2009-09-20 |
| 000A     | 東京      | 0007      | 30    | おろしがね     | キッチン用品  | 880          | 790          | 2008-04-28 |
| 000A     | 東京      | 0008      | 30    | ボールペン     | 事務用品      | 100          |              | 2009-11-11 |
| 000A     | 東京      | 0001      | 50    | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 000A     | 東京      | 0002      | 50    | 穴あけパンチ   | 事務用品      | 500          | 320          | 2009-09-11 |
| 000A     | 東京      | 0003      | 50    | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 000A     | 東京      | 0004      | 50    | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 000A     | 東京      | 0005      | 50    | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 000A     | 東京      | 0006      | 50    | フォーク       | キッチン用品  | 500          |              | 2009-09-20 |
| 000A     | 東京      | 0007      | 50    | おろしがね     | キッチン用品  | 880          | 790          | 2008-04-28 |
| 000A     | 東京      | 0008      | 50    | ボールペン     | 事務用品      | 100          |              | 2009-11-11 |
| 000A     | 東京      | 0001      | 1     | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 000A     | 東京      | 0002      | 1     | 穴あけパンチ   | 事務用品      | 500          | 320          | 2009-09-11 |
| 000A     | 東京      | 0003      | 1     | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 000A     | 東京      | 0004      | 1     | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 000A     | 東京      | 0005      | 1     | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 000A     | 東京      | 0006      | 1     | フォーク       | キッチン用品  | 500          |              | 2009-09-20 |
| 000A     | 東京      | 0007      | 1     | おろしがね     | キッチン用品  | 880          | 790          | 2008-04-28 |
| 000A     | 東京      | 0008      | 1     | ボールペン     | 事務用品      | 100          |              | 2009-11-11 |
| 000B     | 名古屋    | 0001      | 30    | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 000B     | 名古屋    | 0002      | 30    | 穴あけパンチ   | 事務用品      | 500          | 320          | 2009-09-11 |
| 000B     | 名古屋    | 0003      | 30    | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 000B     | 名古屋    | 0004      | 30    | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 000B     | 名古屋    | 0005      | 30    | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 000B     | 名古屋    | 0006      | 30    | フォーク       | キッチン用品  | 500          |              | 2009-09-20 |
| 000B     | 名古屋    | 0007      | 30    | おろしがね     | キッチン用品  | 880          | 790          | 2008-04-28 |
| 000B     | 名古屋    | 0008      | 30    | ボールペン     | 事務用品      | 100          |              | 2009-11-11 |
| 000B     | 名古屋    | 0001      | 12    | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 000B     | 名古屋    | 0002      | 12    | 穴あけパンチ   | 事務用品      | 500          | 320          | 2009-09-11 |
| 000B     | 名古屋    | 0003      | 12    | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 000B     | 名古屋    | 0004      | 12    | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 000B     | 名古屋    | 0005      | 12    | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 000B     | 名古屋    | 0006      | 12    | フォーク       | キッチン用品  | 500          |              | 2009-09-20 |
| 000B     | 名古屋    | 0007      | 12    | おろしがね     | キッチン用品  | 880          | 790          | 2008-04-28 |
| 000B     | 名古屋    | 0008      | 12    | ボールペン     | 事務用品      | 100          |              | 2009-11-11 |
| 000B     | 名古屋    | 0001      | 20    | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 000B     | 名古屋    | 0002      | 20    | 穴あけパンチ   | 事務用品      | 500          | 320          | 2009-09-11 |
| 000B     | 名古屋    | 0003      | 20    | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 000B     | 名古屋    | 0004      | 20    | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 000B     | 名古屋    | 0005      | 20    | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 000B     | 名古屋    | 0006      | 20    | フォーク       | キッチン用品  | 500          |              | 2009-09-20 |
| 000B     | 名古屋    | 0007      | 20    | おろしがね     | キッチン用品  | 880          | 790          | 2008-04-28 |
| 000B     | 名古屋    | 0008      | 20    | ボールペン     | 事務用品      | 100          |              | 2009-11-11 |
| 000B     | 名古屋    | 0001      | 10    | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 000B     | 名古屋    | 0002      | 10    | 穴あけパンチ   | 事務用品      | 500          | 320          | 2009-09-11 |
| 000B     | 名古屋    | 0003      | 10    | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 000B     | 名古屋    | 0004      | 10    | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 000B     | 名古屋    | 0005      | 10    | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 000B     | 名古屋    | 0006      | 10    | フォーク       | キッチン用品  | 500          |              | 2009-09-20 |
| 000B     | 名古屋    | 0007      | 10    | おろしがね     | キッチン用品  | 880          | 790          | 2008-04-28 |
| 000B     | 名古屋    | 0008      | 10    | ボールペン     | 事務用品      | 100          |              | 2009-11-11 |
| 000B     | 名古屋    | 0001      | 40    | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 000B     | 名古屋    | 0002      | 40    | 穴あけパンチ   | 事務用品      | 500          | 320          | 2009-09-11 |
| 000B     | 名古屋    | 0003      | 40    | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 000B     | 名古屋    | 0004      | 40    | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 000B     | 名古屋    | 0005      | 40    | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 000B     | 名古屋    | 0006      | 40    | フォーク       | キッチン用品  | 500          |              | 2009-09-20 |
| 000B     | 名古屋    | 0007      | 40    | おろしがね     | キッチン用品  | 880          | 790          | 2008-04-28 |
| 000B     | 名古屋    | 0008      | 40    | ボールペン     | 事務用品      | 100          |              | 2009-11-11 |
| 000C     | 大阪      | 0001      | 20    | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 000C     | 大阪      | 0002      | 20    | 穴あけパンチ   | 事務用品      | 500          | 320          | 2009-09-11 |
| 000C     | 大阪      | 0003      | 20    | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 000C     | 大阪      | 0004      | 20    | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 000C     | 大阪      | 0005      | 20    | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 000C     | 大阪      | 0006      | 20    | フォーク       | キッチン用品  | 500          |              | 2009-09-20 |
| 000C     | 大阪      | 0007      | 20    | おろしがね     | キッチン用品  | 880          | 790          | 2008-04-28 |
| 000C     | 大阪      | 0008      | 20    | ボールペン     | 事務用品      | 100          |              | 2009-11-11 |
| 000C     | 大阪      | 0001      | 50    | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 000C     | 大阪      | 0002      | 50    | 穴あけパンチ   | 事務用品      | 500          | 320          | 2009-09-11 |
| 000C     | 大阪      | 0003      | 50    | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 000C     | 大阪      | 0004      | 50    | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 000C     | 大阪      | 0005      | 50    | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 000C     | 大阪      | 0006      | 50    | フォーク       | キッチン用品  | 500          |              | 2009-09-20 |
| 000C     | 大阪      | 0007      | 50    | おろしがね     | キッチン用品  | 880          | 790          | 2008-04-28 |
| 000C     | 大阪      | 0008      | 50    | ボールペン     | 事務用品      | 100          |              | 2009-11-11 |
| 000C     | 大阪      | 0001      | 90    | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 000C     | 大阪      | 0002      | 90    | 穴あけパンチ   | 事務用品      | 500          | 320          | 2009-09-11 |
| 000C     | 大阪      | 0003      | 90    | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 000C     | 大阪      | 0004      | 90    | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 000C     | 大阪      | 0005      | 90    | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 000C     | 大阪      | 0006      | 90    | フォーク       | キッチン用品  | 500          |              | 2009-09-20 |
| 000C     | 大阪      | 0007      | 90    | おろしがね     | キッチン用品  | 880          | 790          | 2008-04-28 |
| 000C     | 大阪      | 0008      | 90    | ボールペン     | 事務用品      | 100          |              | 2009-11-11 |
| 000C     | 大阪      | 0001      | 70    | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 000C     | 大阪      | 0002      | 70    | 穴あけパンチ   | 事務用品      | 500          | 320          | 2009-09-11 |
| 000C     | 大阪      | 0003      | 70    | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 000C     | 大阪      | 0004      | 70    | 包丁           | キッチン用品  | 3000         | 2800         | 2009-09-20 |
| 000C     | 大阪      | 0005      | 70    | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 000C     | 大阪      | 0006      | 70    | フォーク       | キッチン用品  | 500          |              | 2009-09-20 |
| 000C     | 大阪      | 0007      | 70    | おろしがね     | キッチン用品  | 880          | 790          | 2008-04-28 |
| 000C     | 大阪      | 0008      | 70    | ボールペン     | 事務用品      | 100          |              | 2009-11-11 |
| 000D     | 福岡      | 0001      | 100   | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
+----------+-----------+-----------+-------+----------------+---------------+--------------+--------------+------------+
104 rows in set
```

```
    > SELECT shohin_bunrui,
    ->   sum(hanbai_tanka) as sum
    -> FROM Shohin
    -> GROUP BY shohin_bunrui with rollup;
    +--------------------+-------+
    | shohin_bunrui      | sum   |
    +--------------------+-------+
    | キッチン用品       | 11180 |
    | 事務用品           |   600 |
    | 衣服               |  5000 |
    | NULL               | 16780 |
    +--------------------+-------+
    4 rows in set (0.06 sec)
```

練習問題

## 2.1 Shohin から、「 登録日（torokubi）が 2009 年 4 月 28 日 以降」である商品を選択する

```
> Shohin.where('torokubi <= ?','2009-04-28')
  Shohin Load (0.7ms)  SELECT `Shohin`.* FROM `Shohin` WHERE (torokubi <= '2009-04-28')
+-----------+------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+------------+---------------+--------------+--------------+------------+
| 0005      | 圧力鍋     | キッチン用品  | 6800         | 5000         | 2009-01-15 |
| 0007      | おろしがね | キッチン用品  | 880          | 790          | 2008-04-28 |
+-----------+------------+---------------+--------------+--------------+------------+
2 rows in set
```

## 2.2

## 2.3 販売単価（hanbai_ tanka）が仕入単価（shiire_tanka）より 500 円以上高い」商品を選択する

```
> Shohin.where('hanbai_tanka >= shiire_tanka + 500')
> Shohin.where('hanbai_tanka - 500 >= shiire_tanka')
> Shohin.where('hanbai_tanka - shiire_tanka >= 500')

どれも
+-----------+----------------+---------------+--------------+--------------+------------+
| shohin_id | shohin_mei     | shohin_bunrui | hanbai_tanka | shiire_tanka | torokubi   |
+-----------+----------------+---------------+--------------+--------------+------------+
| 0001      | Tシャツ        | 衣服          | 1000         | 500          | 2009-09-20 |
| 0003      | カッターシャツ | 衣服          | 4000         | 2800         |            |
| 0005      | 圧力鍋         | キッチン用品  | 6800         | 5000         | 2009-01-15 |
+-----------+----------------+---------------+--------------+--------------+------------+
3 rows in set
```

## 2.4 から、「 販売単価を 10％ 引きにしても利益が 100 円 より高い事務用品とキッチン用品」を 選択

```
> Shohin.where(shohin_bunrui: ['事務用品', 'キッチン用品']).where('hanbai_tanka * 0.9 - shiire_tanka > 100').select('shohin_mei, shohin_bunrui, shiire_tanka, hanbai_tanka AS "定価", hanbai_tanka * 0.9 AS "10% OFF", hanbai_tanka * 0.9 - shiire_tanka AS rieki')
  Shohin Load (0.5ms)  SELECT shohin_mei, shohin_bunrui, shiire_tanka, hanbai_tanka AS "定価", hanbai_tanka * 0.9 AS "10% OFF", hanbai_tanka * 0.9 - shiire_tanka AS rieki FROM `Shohin` WHERE `Shohin`.`shohin_bunrui` IN ('事務用品', 'キッチン用品') AND (hanbai_tanka * 0.9 - shiire_tanka > 100)
+-----------+--------------+---------------+--------------+------+---------+--------+
| shohin_id | shohin_mei   | shohin_bunrui | shiire_tanka | 定価 | 10% OFF | rieki  |
+-----------+--------------+---------------+--------------+------+---------+--------+
|           | 穴あけパンチ | 事務用品      | 320          | 500  | 450.0   | 130.0  |
|           | 圧力鍋       | キッチン用品  | 5000         | 6800 | 6120.0  | 1120.0 |
+-----------+--------------+---------------+--------------+------+---------+--------+
2 rows in set
```

## 3-1
