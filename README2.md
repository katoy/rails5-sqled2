書籍 "スッキリわかるSQL入門 ドリル215問付き！" にあるサンプルを MySQL + Rails 5 で試してみた。
     https://www.amazon.co.jp/dp/B00IRRTFNG/

## 1.1
```
> Household.select(:outcome)
  Household Load (0.4ms)  SELECT `Household`.`outcome` FROM `Household`
+----+---------+
| id | outcome |
+----+---------+
|    | 380     |
|    | 0       |
|    | 2800    |
|    | 5000    |
|    | 7560    |
+----+---------+
5 rows in set
```

## 1.2
```
> Household.select(:day, :item, :memo, :outcome, :income)
  Household Load (0.6ms)  SELECT `Household`.`day`, `Household`.`item`, `Household`.`memo`, `Household`.`outcome`, `Household`.`income` FROM `Household`
+----+------------+------------+----------------+--------+---------+
| id | day        | item       | memo           | income | outcome |
+----+------------+------------+----------------+--------+---------+
|    | 2013-02-03 | 食費       | コーヒーを購入 | 0      | 380     |
|    | 2013-02-10 | 給料       | 1月の給料      | 280000 | 0       |
|    | 2013-02-11 | 教養娯楽費 | 書籍を購入     | 0      | 2800    |
|    | 2013-02-14 | 交際費     | 同期会の会費   | 0      | 5000    |
|    | 2013-02-18 | 水道光熱費 | 1月の電気代    | 0      | 7560    |
+----+------------+------------+----------------+--------+---------+
5 rows in set
```

## 1.3
```
> Household.select('*')
  Household Load (0.4ms)  SELECT * FROM `Household`
+----+------------+------------+----------------+--------+---------+
| id | day        | item       | memo           | income | outcome |
+----+------------+------------+----------------+--------+---------+
| 1  | 2013-02-03 | 食費       | コーヒーを購入 | 0      | 380     |
| 2  | 2013-02-10 | 給料       | 1月の給料      | 280000 | 0       |
| 3  | 2013-02-11 | 教養娯楽費 | 書籍を購入     | 0      | 2800    |
| 4  | 2013-02-14 | 交際費     | 同期会の会費   | 0      | 5000    |
| 5  | 2013-02-18 | 水道光熱費 | 1月の電気代    | 0      | 7560    |
+----+------------+------------+----------------+--------+---------+
5 rows in set
```

## 1.4
```
> Household.where('outcome > ?', 3000).select(:day, :item, :outcome)
  Household Load (0.4ms)  SELECT `Household`.`day`, `Household`.`item`, `Household`.`outcome` FROM `Household` WHERE (outcome > 3000)
+----+------------+------------+---------+
| id | day        | item       | outcome |
+----+------------+------------+---------+
|    | 2013-02-14 | 交際費     | 5000    |
|    | 2013-02-18 | 水道光熱費 | 7560    |
+----+------------+------------+---------+
2 rows in set
```

## 1.5
```
> Household.create(day: '2013-03-25', item: '居住費', memo: '3月の家賃', income: 0, outcome:85000)

   (0.2ms)  BEGIN
  SQL (0.4ms)  INSERT INTO `Household` (`day`, `item`, `memo`, `income`, `outcome`) VALUES ('2013-03-25', '居住費', '3月の家賃', 0, 85000)
   (54.2ms)  COMMIT
+----+------------+--------+-----------+--------+---------+
| id | day        | item   | memo      | income | outcome |
+----+------------+--------+-----------+--------+---------+
| 6  | 2013-03-25 | 居住費 | 3月の家賃 | 0      | 85000   |
+----+------------+--------+-----------+--------+---------+
1 row in set

> Household.all
  Household Load (0.5ms)  SELECT `Household`.* FROM `Household`
+----+------------+------------+----------------+--------+---------+
| id | day        | item       | memo           | income | outcome |
+----+------------+------------+----------------+--------+---------+
| 1  | 2013-02-03 | 食費       | コーヒーを購入 | 0      | 380     |
| 2  | 2013-02-10 | 給料       | 1月の給料      | 280000 | 0       |
| 3  | 2013-02-11 | 教養娯楽費 | 書籍を購入     | 0      | 2800    |
| 4  | 2013-02-14 | 交際費     | 同期会の会費   | 0      | 5000    |
| 5  | 2013-02-18 | 水道光熱費 | 1月の電気代    | 0      | 7560    |
| 6  | 2013-03-25 | 居住費     | 3月の家賃      | 0      | 85000   |
+----+------------+------------+----------------+--------+---------+
6 rows in set
```

## 1.6
```
> Household.find_by(day: '2013-02-25').update!(outcome: 90000)
  Household Load (0.5ms)  SELECT  `Household`.* FROM `Household` WHERE `Household`.`day` = '2013-02-25' LIMIT 1
NoMethodError: undefined method `update!' for nil:NilClass
from (pry):23:in `<main>'

> Household.all
  Household Load (0.4ms)  SELECT `Household`.* FROM `Household`
+----+------------+------------+----------------+--------+---------+-------------------+
| id | day        | item       | memo           | income | outcome | {:outcome=>90000} |
+----+------------+------------+----------------+--------+---------+-------------------+
| 1  | 2013-02-03 | 食費       | コーヒーを購入 | 0      | 380     |                   |
| 2  | 2013-02-10 | 給料       | 1月の給料      | 280000 | 0       |                   |
| 3  | 2013-02-11 | 教養娯楽費 | 書籍を購入     | 0      | 2800    |                   |
| 4  | 2013-02-14 | 交際費     | 同期会の会費   | 0      | 5000    |                   |
| 5  | 2013-02-18 | 水道光熱費 | 1月の電気代    | 0      | 7560    |                   |
| 6  | 2013-03-25 | 居住費     | 3月の家賃      | 0      | 90000   |                   |
+----+------------+------------+----------------+-------
6 rows in set
```

## 1.7
```
> Household.find_by(day: '2013-03-25').destroy
  Household Load (0.5ms)  SELECT  `Household`.* FROM `Household` WHERE `Household`.`day` = '2013-03-25' LIMIT 1
   (0.2ms)  BEGIN
  SQL (0.7ms)  DELETE FROM `Household` WHERE `Household`.`id` = 6
   (28.1ms)  COMMIT
+----+------------+--------+-----------+--------+---------+-------------------+
| id | day        | item   | memo      | income | outcome | {:outcome=>90000} |
+----+------------+--------+-----------+--------+---------+-------------------+
| 6  | 2013-03-25 | 居住費 | 3月の家賃 | 0      | 90000   |                   |
+----+------------+--------+-----------+--------+---------+-------------------+
1 row in set

> Household.all
  Household Load (0.4ms)  SELECT `Household`.* FROM `Household`
+----+------------+------------+----------------+--------+---------+-------------------+
| id | day        | item       | memo           | income | outcome | {:outcome=>90000} |
+----+------------+------------+----------------+--------+---------+-------------------+
| 1  | 2013-02-03 | 食費       | コーヒーを購入 | 0      | 380     |                   |
| 2  | 2013-02-10 | 給料       | 1月の給料      | 280000 | 0       |                   |
| 3  | 2013-02-11 | 教養娯楽費 | 書籍を購入     | 0      | 2800    |                   |
| 4  | 2013-02-14 | 交際費     | 同期会の会費   | 0      | 5000    |                   |
| 5  | 2013-02-18 | 水道光熱費 | 1月の電気代    | 0      | 7560    |                   |
+----+------------+------------+----------------+--------+---------+-------------------+
5 rows in set
```

## 2-1
```
[32] pry(main)> Household.where('outcome > ?', 3000).select(:item, :outcome)
  Household Load (0.4ms)  SELECT `Household`.`item`, `Household`.`outcome` FROM `Household` WHERE (outcome > 3000)
+----+------------+---------+-------------------+
| id | item       | outcome | {:outcome=>90000} |
+----+------------+---------+-------------------+
|    | 交際費     | 5000    |                   |
|    | 水道光熱費 | 7560    |                   |
+----+------------+---------+-------------------+
2 rows in set
```

## 2-2

## 2-3

## 2-4

## 2-5

## 2-6
```
> Household.select(:item, :income, :outcome)
  Household Load (0.3ms)  SELECT `Household`.`item`, `Household`.`income`, `Household`.`outcome` FROM `Household`
+----+------------+--------+---------+
| id | item       | income | outcome |
+----+------------+--------+---------+
|    | 食費       | 0      | 380     |
|    | 給料       | 280000 | 0       |
|    | 教養娯楽費 | 0      | 2800    |
|    | 交際費     | 0      | 5000    |
|    | 水道光熱費 | 0      | 7560    |
+----+------------+--------+---------+
5 rows in set
```

## 2-7
```
> Household.select('item as 項目', 'income as 入金', 'outcome as 出金')
  Household Load (0.4ms)  SELECT item as 項目, income as 入金, outcome as 出金 FROM `Household`
+----+------------+--------+------+
| id | 項目       | 入金   | 出金 |
+----+------------+--------+------+
|    | 食費       | 0      | 380  |
|    | 給料       | 280000 | 0    |
|    | 教養娯楽費 | 0      | 2800 |
|    | 交際費     | 0      | 5000 |
|    | 水道光熱費 | 0      | 7560 |
+----+------------+--------+------+
5 rows in set
```

## 2-8
```
> Household.update_all(outcome: 9999)
  SQL (0.7ms)  UPDATE `Household` SET `Household`.`outcome` = 9999
=> 5
[2] pry(main)> Household.all
  Household Load (1.0ms)  SELECT `Household`.* FROM `Household`
+----+------------+------------+----------------+--------+---------+
| id | day        | item       | memo           | income | outcome |
+----+------------+------------+----------------+--------+---------+
| 1  | 2013-02-03 | 食費       | コーヒーを購入 | 0      | 9999    |
| 2  | 2013-02-10 | 給料       | 1月の給料      | 280000 | 9999    |
| 3  | 2013-02-11 | 教養娯楽費 | 書籍を購入     | 0      | 9999    |
| 4  | 2013-02-14 | 交際費     | 同期会の会費   | 0      | 9999    |
| 5  | 2013-02-18 | 水道光熱費 | 1月の電気代    | 0      | 9999    |
+----+------------+------------+----------------+--------+---------+
5 rows in set
```

## 2-9
```
> Household.where(day: '2013-02-03').update_all(outcome: 9999)
  SQL (0.9ms)  UPDATE `Household` SET `Household`.`outcome` = 9999 WHERE `Household`.`day` = '2013-02-03'
=> 1

> Household.all
  Household Load (0.6ms)  SELECT `Household`.* FROM `Household`
+----+------------+------------+----------------+--------+---------+
| id | day        | item       | memo           | income | outcome |
+----+------------+------------+----------------+--------+---------+
| 1  | 2013-02-03 | 食費       | コーヒーを購入 | 0      | 9999    |
| 2  | 2013-02-10 | 給料       | 1月の給料      | 280000 | 0       |
| 3  | 2013-02-11 | 教養娯楽費 | 書籍を購入     | 0      | 2800    |
| 4  | 2013-02-14 | 交際費     | 同期会の会費   | 0      | 5000    |
| 5  | 2013-02-18 | 水道光熱費 | 1月の電気代    | 0      | 7560    |
+----+------------+------------+----------------+--------+---------+
5 rows in set
```

## 2-9

## 2-10

## 2-11
```
> Household.create(item: '通信費', day: '2013-02-20', outcome: 6200)
   (0.3ms)  BEGIN
  SQL (0.4ms)  INSERT INTO `Household` (`day`, `item`, `outcome`) VALUES ('2013-02-20', '通信費', 6200)
   (0.5ms)  COMMIT
+----+------------+--------+------+--------+---------+
| id | day        | item   | memo | income | outcome |
+----+------------+--------+------+--------+---------+
| 6  | 2013-02-20 | 通信費 |      | 0      | 6200    |
+----+------------+--------+------+--------+---------+
1 row in set
[2] pry(main)> Household.all
  Household Load (0.4ms)  SELECT `Household`.* FROM `Household`
+----+------------+------------+----------------+--------+---------+
| id | day        | item       | memo           | income | outcome |
+----+------------+------------+----------------+--------+---------+
| 1  | 2013-02-03 | 食費       | コーヒーを購入 | 0      | 380     |
| 2  | 2013-02-10 | 給料       | 1月の給料      | 280000 | 0       |
| 3  | 2013-02-11 | 教養娯楽費 | 書籍を購入     | 0      | 2800    |
| 4  | 2013-02-14 | 交際費     | 同期会の会費   | 0      | 5000    |
| 5  | 2013-02-18 | 水道光熱費 | 1月の電気代    | 0      | 7560    |
| 6  | 2013-02-20 | 通信費     |                | 0      | 6200    |
+----+------------+------------+----------------+--------+---------+
6 rows in set
```

## 2-12

## 3-1
```
> Household.where('outcome > 0')
  Household Load (0.6ms)  SELECT `Household`.* FROM `Household` WHERE (outcome > 0)
+----+------------+------------+----------------+--------+---------+
| id | day        | item       | memo           | income | outcome |
+----+------------+------------+----------------+--------+---------+
| 1  | 2013-02-03 | 食費       | コーヒーを購入 | 0      | 380     |
| 3  | 2013-02-11 | 教養娯楽費 | 書籍を購入     | 0      | 2800    |
| 4  | 2013-02-14 | 交際費     | 同期会の会費   | 0      | 5000    |
| 5  | 2013-02-18 | 水道光熱費 | 1月の電気代    | 0      | 7560    |
| 6  | 2013-02-20 | 通信費     |                | 0      | 6200    |
+----+------------+------------+----------------+--------+---------+
5 rows in set
```

## 3-2
```
> Household.where(outcome: nil)
  Household Load (0.3ms)  SELECT `Household`.* FROM `Household` WHERE `Household`.`outcome` IS NULL
=> []
```

## 3-3
```
> Household.where('memo like ?', '%1月%')
  Household Load (0.4ms)  SELECT `Household`.* FROM `Household` WHERE (memo like '%1月%')
+----+------------+------------+-------------+--------+---------+
| id | day        | item       | memo        | income | outcome |
+----+------------+------------+-------------+--------+---------+
| 2  | 2013-02-10 | 給料       | 1月の給料   | 280000 | 0       |
| 5  | 2013-02-18 | 水道光熱費 | 1月の電気代 | 0      | 7560    |
+----+------------+------------+-------------+--------+---------+
2 rows in set
```

## 3-4
```
> Household.where(outcome: [100..3000])
  Household Load (3.8ms)  SELECT `Household`.* FROM `Household` WHERE (`Household`.`outcome` BETWEEN 100 AND 3000)
+----+------------+------------+----------------+--------+---------+
| id | day        | item       | memo           | income | outcome |
+----+------------+------------+----------------+--------+---------+
| 1  | 2013-02-03 | 食費       | コーヒーを購入 | 0      | 380     |
| 3  | 2013-02-11 | 教養娯楽費 | 書籍を購入     | 0      | 2800    |
+----+------------+------------+----------------+--------+---------+
2 rows in set
```

## 3-5
```
> Household.where(item: ['食費', '交際費'])
  Household Load (2.2ms)  SELECT `Household`.* FROM `Household` WHERE `Household`.`item` IN ('食費', '交際費')
+----+------------+--------+----------------+--------+---------+
| id | day        | item   | memo           | income | outcome |
+----+------------+--------+----------------+--------+---------+
| 1  | 2013-02-03 | 食費   | コーヒーを購入 | 0      | 380     |
| 4  | 2013-02-14 | 交際費 | 同期会の会費   | 0      | 5000    |
+----+------------+--------+----------------+--------+---------+
2 rows in set
```

## 3-6
```
> Household.where.not(item: ['食費', '交際費'])
  Household Load (0.5ms)  SELECT `Household`.* FROM `Household` WHERE (`Household`.`item` NOT IN ('食費', '交際費'))
+----+------------+------------+-------------+--------+---------+
| id | day        | item       | memo        | income | outcome |
+----+------------+------------+-------------+--------+---------+
| 2  | 2013-02-10 | 給料       | 1月の給料   | 280000 | 0       |
| 3  | 2013-02-11 | 教養娯楽費 | 書籍を購入  | 0      | 2800    |
| 5  | 2013-02-18 | 水道光熱費 | 1月の電気代 | 0      | 7560    |
| 6  | 2013-02-20 | 通信費     |             | 0      | 6200    |
+----+------------+------------+-------------+--------+---------+
4 rows in set
```

## 4-1
```
> Household.select(:income)
  Household Load (0.4ms)  SELECT `Household`.`income` FROM `Household`
+----+--------+
| id | income |
+----+--------+
|    | 0      |
|    | 280000 |
|    | 0      |
|    | 0      |
|    | 0      |
|    | 0      |
+----+--------+
```

## 4-2
```
> Household.select(:income).distinct
  Household Load (0.6ms)  SELECT DISTINCT `Household`.`income` FROM `Household`
+----+--------+
| id | income |
+----+--------+
|    | 0      |
|    | 280000 |
+----+--------+
2 rows in set
```

## 4-3
```
> Household.select(:item).distinct
  Household Load (0.9ms)  SELECT DISTINCT `Household`.`item` FROM `Household`
+----+------------+
| id | item       |
+----+------------+
|    | 食費       |
|    | 給料       |
|    | 教養娯楽費 |
|    | 交際費     |
|    | 水道光熱費 |
|    | 通信費     |
+----+------------+
6 rows in set
```

## 4-4
```
> Household.order( outcome: :asc)
  Household Load (0.9ms)  SELECT `Household`.* FROM `Household` ORDER BY `Household`.`outcome` ASC
+----+------------+------------+----------------+--------+---------+
| id | day        | item       | memo           | income | outcome |
+----+------------+------------+----------------+--------+---------+
| 2  | 2013-02-10 | 給料       | 1月の給料      | 280000 | 0       |
| 1  | 2013-02-03 | 食費       | コーヒーを購入 | 0      | 380     |
| 3  | 2013-02-11 | 教養娯楽費 | 書籍を購入     | 0      | 2800    |
| 4  | 2013-02-14 | 交際費     | 同期会の会費   | 0      | 5000    |
| 6  | 2013-02-20 | 通信費     |                | 0      | 6200    |
| 5  | 2013-02-18 | 水道光熱費 | 1月の電気代    | 0      | 7560    |
+----+------------+------------+----------------+--------+---------+
6 rows in set
```

## 4-5
```
> Household.order(day: :desc)
  Household Load (0.5ms)  SELECT `Household`.* FROM `Household` ORDER BY `Household`.`day` DESC
+----+------------+------------+----------------+--------+---------+
| id | day        | item       | memo           | income | outcome |
+----+------------+------------+----------------+--------+---------+
| 6  | 2013-02-20 | 通信費     |                | 0      | 6200    |
| 5  | 2013-02-18 | 水道光熱費 | 1月の電気代    | 0      | 7560    |
| 4  | 2013-02-14 | 交際費     | 同期会の会費   | 0      | 5000    |
| 3  | 2013-02-11 | 教養娯楽費 | 書籍を購入     | 0      | 2800    |
| 2  | 2013-02-10 | 給料       | 1月の給料      | 280000 | 0       |
| 1  | 2013-02-03 | 食費       | コーヒーを購入 | 0      | 380     |
+----+------------+------------+----------------+--------+---------+
6 rows in set
```

## 4-6
```
> Household.order(income: :desc, outcome: :desc)
  Household Load (1.9ms)  SELECT `Household`.* FROM `Household` ORDER BY `Household`.`income` DESC, `Household`.`outcome` DESC
+----+------------+------------+----------------+--------+---------+
| id | day        | item       | memo           | income | outcome |
+----+------------+------------+----------------+--------+---------+
| 2  | 2013-02-10 | 給料       | 1月の給料      | 280000 | 0       |
| 5  | 2013-02-18 | 水道光熱費 | 1月の電気代    | 0      | 7560    |
| 6  | 2013-02-20 | 通信費     |                | 0      | 6200    |
| 4  | 2013-02-14 | 交際費     | 同期会の会費   | 0      | 5000    |
| 3  | 2013-02-11 | 教養娯楽費 | 書籍を購入     | 0      | 2800    |
| 1  | 2013-02-03 | 食費       | コーヒーを購入 | 0      | 380     |
+----+------------+------------+----------------+--------+---------+
6 rows in set
```

## 4-7
```
> Household.order('5 desc', '6 desc')
  Household Load (0.6ms)  SELECT `Household`.* FROM `Household` ORDER BY 5 desc, 6 desc
+----+------------+------------+----------------+--------+---------+
| id | day        | item       | memo           | income | outcome |
+----+------------+------------+----------------+--------+---------+
| 2  | 2013-02-10 | 給料       | 1月の給料      | 280000 | 0       |
| 5  | 2013-02-18 | 水道光熱費 | 1月の電気代    | 0      | 7560    |
| 6  | 2013-02-20 | 通信費     |                | 0      | 6200    |
| 4  | 2013-02-14 | 交際費     | 同期会の会費   | 0      | 5000    |
| 3  | 2013-02-11 | 教養娯楽費 | 書籍を購入     | 0      | 2800    |
| 1  | 2013-02-03 | 食費       | コーヒーを購入 | 0      | 380     |
+----+------------+------------+----------------+--------+---------+
6 rows in set
```

## 4-8
```
> Household.order(outcome: :desc).select(:item, :outcome).limit(3)
  Household Load (0.4ms)  SELECT  `Household`.`item`, `Household`.`outcome` FROM `Household` ORDER BY `Household`.`outcome` DESC LIMIT 3
+----+------------+---------+
| id | item       | outcome |
+----+------------+---------+
|    | 水道光熱費 | 7560    |
|    | 通信費     | 6200    |
|    | 交際費     | 5000    |
+----+------------+---------+
3 rows in set
```

## 4-9
```
> Household.order(outcome: :desc).select(:item, :outcome).limit(1).offset(2)
  Household Load (0.4ms)  SELECT  `Household`.`item`, `Household`.`outcome` FROM `Household` ORDER BY `Household`.`outcome` DESC LIMIT 1 OFFSET 2
+----+--------+---------+
| id | item   | outcome |
+----+--------+---------+
|    | 交際費 | 5000    |
+----+--------+---------+
1 row in set
```

## 4-10

## 4-11
```
[14] pry(main)> Household.find_by_sql('select item, income, outcome from Household union select item, income, outcome from HouseholdArchive order by income, outcome, item')

  Household Load (0.5ms)  select item, income, outcome from Household union select item, income, outcome from HouseholdArchive order by income, outcome, item
+----+------------+--------+---------+
| id | item       | income | outcome |
+----+------------+--------+---------+
|    | 食費       | 0      | 380     |
|    | 教養娯楽費 | 0      | 1800    |
|    | 教養娯楽費 | 0      | 2800    |
|    | 水道光熱費 | 0      | 4200    |
|    | 交際費     | 0      | 5000    |
|    | 食費       | 0      | 5000    |
|    | 水道光熱費 | 0      | 7560    |
|    | 居住費     | 0      | 80000   |
|    | 給料       | 280000 | 0       |
+----+------------+--------+---------+
9 rows in set
```

## 5-1
```
> Household.select(:outcome, 'outcome + 100', '"SQL"')
  Household Load (0.4ms)  SELECT `Household`.`outcome`, outcome + 100, "SQL" FROM `Household`
+----+---------+---------------+-----+
| id | outcome | outcome + 100 | SQL |
+----+---------+---------------+-----+
|    | 380     | 480           | SQL |
|    | 0       | 100           | SQL |
|    | 2800    | 2900          | SQL |
|    | 5000    | 5100          | SQL |
|    | 7560    | 7660          | SQL |
+----+---------+---------------+-----+
5 rows in set
```

## 5-2
```
> Household.select(:outcome, 'outcome + 100 as 百円増しの出金額')
  Household Load (0.4ms)  SELECT `Household`.`outcome`, outcome + 100 as 百円増しの出金額 FROM `Household`
+----+---------+------------------+
| id | outcome | 百円増しの出金額 |
+----+---------+------------------+
|    | 380     | 480              |
|    | 0       | 100              |
|    | 2800    | 2900             |
|    | 5000    | 5100             |
|    | 7560    | 7660             |
+----+---------+------------------+
5 rows in set
```

## 5-3

## 5-4

## 5-5

## 5-6

## 5-7
```
[2] pry(main)> Household.select(:memo, 'length(memo) as "メモの長さ(lengh)"', 'char_length(memo) as "メモの長さ(char_length)"')

  Household Load (0.5ms)  SELECT `Household`.`memo`, length(memo) as "メモの長さ(lengh)", char_length(memo) as "メモの長さ(char_length)" FROM `Household`
+----+----------------+-------------------+-------------------------+
| id | memo           | メモの長さ(lengh) | メモの長さ(char_length) |
+----+----------------+-------------------+-------------------------+
|    | コーヒーを購入 | 21                | 7                       |
|    | 1月の給料      | 13                | 5                       |
|    | 書籍を購入     | 15                | 5                       |
|    | 同期会の会費   | 18                | 6                       |
|    | 1月の電気代    | 16                | 6                       |
+----+----------------+-------------------+-------------------------+
5 rows in set
```

## 5-8
```
> Household.where('char_length(memo) <= 5')
  Household Load (0.4ms)  SELECT `Household`.* FROM `Household` WHERE (char_length(memo) <= 5)
+----+------------+------------+------------+--------+---------+
| id | day        | item       | memo       | income | outcome |
+----+------------+------------+------------+--------+---------+
| 2  | 2013-02-10 | 給料       | 1月の給料  | 280000 | 0       |
| 3  | 2013-02-11 | 教養娯楽費 | 書籍を購入 | 0      | 2800    |
+----+------------+------------+------------+--------+---------+
2 rows in set
```

## 5-9

## 5-10

## 5-11
```
> Household.where('substring(item, 1, 3) like "%費%"')
  Household Load (0.5ms)  SELECT `Household`.* FROM `Household` WHERE (substring(item, 1, 3) like "%費%")
+----+------------+--------+----------------+--------+---------+
| id | day        | item   | memo           | income | outcome |
+----+------------+--------+----------------+--------+---------+
| 1  | 2013-02-03 | 食費   | コーヒーを購入 | 0      | 380     |
| 4  | 2013-02-14 | 交際費 | 同期会の会費   | 0      | 5000    |
+----+------------+--------+----------------+-----
```

## 5-12
```
> Household.select(:outcome, 'ROUND(outcome, -2) AS "百円単位で四捨五入した出[10] pry(main)> Household.select(:outcome, 'ROUND(outcome, -2) AS "百円単位で四捨五入した出  Household Load (0.4ms)  SELECT `Household`.`outcome`, ROUND(outcome, -2) AS "百円単位で四捨五入した出金額" FROM `Household`
+----+---------+------------------------------+
| id | outcome | 百円単位で四捨五入した出金額 |
+----+---------+------------------------------+
|    | 380     | 400                          |
|    | 0       | 0                            |
|    | 2800    | 2800                         |
|    | 5000    | 5000                         |
|    | 7560    | 7600                         |
+----+---------+------------------------------+
5 rows in set
```

## 5-13

## 5-14

## 5-15

## 5-16

## 6-1
```
> Household.select('sum(outcome) AS "合計"')
  Household Load (0.4ms)  SELECT sum(outcome) AS "合計" FROM `Household`
+----+-------+
| id | 合計  |
+----+-------+
|    | 15740 |
+----+-------+
1 row in set
```

```
> Household.sum(:outcome)
   (0.3ms)  SELECT SUM(`Household`.`outcome`) FROM `Household`
=> 15740
```

## 6-2
```
> Household.select('sum(outcome) as "sum", avg(outcome) as "average", max(outcome) as "max", min(outcome) as "min"')

  Household Load (0.8ms)  SELECT sum(outcome) as "sum", avg(outcome) as "average", max(outcome) as "max", min(outcome) as "min" FROM `Household`
+----+-------+---------+------+-----+
| id | sum   | average | max  | min |
+----+-------+---------+------+-----+
|    | 15740 | 3148.0  | 7560 | 0   |
+----+-------+---------+------+-----+
1 row in set
[30] pry(main
```

## 6-3
```
> Household.where(item: '食費').count
   (0.4ms)  SELECT COUNT(*) FROM `Household` WHERE `Household`.`item` = '食費'
=> 1
```

## 6-4

## 6-5

## 6-6
```
[46] pry(main)> Household.group(:item).select(:item, 'sum(outcome) as "項目別の集計"')
  Household Load (0.5ms)  SELECT `Household`.`item`, sum(outcome) as "項目別の集計" FROM `Household` GROUP BY `Household`.`item`
+----+------------+--------------+
| id | item       | 項目別の集計 |
+----+------------+--------------+
|    | 交際費     | 5000         |
|    | 教養娯楽費 | 2800         |
|    | 水道光熱費 | 7560         |
|    | 給料       | 0            |
|    | 食費       | 380          |
+----+------------+--------------+
5 rows in set
```

## 6-8

## 6-9
```
> Household.select(:item, 'sum(outcome) as "項目別の集計"').group(:item).having('sum(outcome) > 0')

  Household Load (0.5ms)  SELECT `Household`.`item`, sum(outcome) as "項目別の集計" FROM `Household` GROUP BY `Household`.`item` HAVING (sum(outcome) > 0)
+----+------------+--------------+
| id | item       | 項目別の集計 |
+----+------------+--------------+
|    | 交際費     | 5000         |
|    | 教養娯楽費 | 2800         |
|    | 水道光熱費 | 7560         |
|    | 食費       | 380          |
+----+------------+--------------+
4 rows in set
```

## 6-10

## 7-1

## 7-2
```
> Household.where(outcome: Household.maximum(:outcome))
   (0.5ms)  SELECT MAX(`Household`.`outcome`) FROM `Household`
  Household Load (0.4ms)  SELECT `Household`.* FROM `Household` WHERE `Household`.`outcome` = 7560
+----+------------+------------+-------------+--------+---------+
| id | day        | item       | memo        | income | outcome |
+----+------------+------------+-------------+--------+---------+
| 5  | 2013-02-18 | 水道光熱費 | 1月の電気代 | 0      | 7560    |
+----+------------+------------+-------------+--------+---------+
1 row in set
```

## 7-3
```
> Summary.find_by(item: '食費').update(average: HouseholdArchive.where('outcome > 0').where(item: '食費').average(:outcome))
  Summary Load (0.4ms)  SELECT  `Summary`.* FROM `Summary` WHERE `Summary`.`item` = '食費' LIMIT 1
   (1.2ms)  SELECT AVG(`HouseholdArchive`.`outcome`) FROM `HouseholdArchive` WHERE (outcome > 0) AND `HouseholdArchive`.`item` = '食費'
   (0.2ms)  BEGIN
  SQL (0.4ms)  UPDATE `Summary` SET `average` = 5000 WHERE `Summary`.`id` = 3
   (0.5ms)  COMMIT
=> true

> Summary.all
  Summary Load (0.4ms)  SELECT `Summary`.* FROM `Summary`
+----+------------+--------+---------+--------+--------+-------+
| id | item       | total  | average | min    | max    | count |
+----+------------+--------+---------+--------+--------+-------+
| 1  | 居住費     | 160000 | 80000   | 80000  | 80000  | 3     |
| 2  | 水道光熱費 | 11760  | 5880    | 4200   | 7560   | 2     |
| 3  | 食費       | 10380  | 5000    | 380    | 5000   | 3     |
| 4  | 教養娯楽費 | 4600   | 2300    | 1800   | 2800   | 2     |
| 5  | 給料       | 840000 | 280000  | 280000 | 280000 | 3     |
+----+------------+--------+---------+--------+--------+-------+
5 rows in set
```

## 7-4
```
> HouseholdArchive.where(item: '食費').select(:day, :memo, :outcome, Household.where(item: '食費').sum(:outcome))
   (0.4ms)  SELECT SUM(`Household`.`outcome`) FROM `Household` WHERE `Household`.`item` = '食費'
  HouseholdArchive Load (0.4ms)  SELECT `HouseholdArchive`.`day`, `HouseholdArchive`.`memo`, `HouseholdArchive`.`outcome`, 380 FROM `HouseholdArchive` WHERE `HouseholdArchive`.`item` = '食費'
+----+------------+------------------+---------+-----+
| id | day        | memo             | outcome | 380 |
+----+------------+------------------+---------+-----+
|    | 2012-12-24 | レストランみやび | 5000    | 380 |
|    | 2013-01-13 | 新年会           | 5000    | 380 |
+----+------------+------------------+---------+-----+
2 rows in set
```

## 7-5
```
> Summary.where(item: ['食費', '水道光熱費', '教養娯楽費', '給料'])
  Summary Load (0.4ms)  SELECT `Summary`.* FROM `Summary` WHERE `Summary`.`item` IN ('食費', '水道光熱費', '教養娯楽費', '給料')
+----+------------+--------+---------+--------+--------+-------+
| id | item       | total  | average | min    | max    | count |
+----+------------+--------+---------+--------+--------+-------+
| 2  | 水道光熱費 | 11760  | 5880    | 4200   | 7560   | 2     |
| 3  | 食費       | 10380  | 5000    | 380    | 5000   | 3     |
| 4  | 教養娯楽費 | 4600   | 2300    | 1800   | 2800   | 2     |
| 5  | 給料       | 840000 | 280000  | 280000 | 280000 | 3     |
+----+------------+--------+---------+--------+--------+-------+
4 rows in set
```

## 7-6
```
> Summary.where(item: Household.select(:item).distinct)
  Summary Load (0.8ms)  SELECT `Summary`.* FROM `Summary` WHERE `Summary`.`item` IN (SELECT DISTINCT `Household`.`item` FROM `Household`)
+----+------------+--------+---------+--------+--------+-------+
| id | item       | total  | average | min    | max    | count |
+----+------------+--------+---------+--------+--------+-------+
| 2  | 水道光熱費 | 11760  | 5880    | 4200   | 7560   | 2     |
| 3  | 食費       | 10380  | 5000    | 380    | 5000   | 3     |
| 4  | 教養娯楽費 | 4600   | 2300    | 1800   | 2800   | 2     |
| 5  | 給料       | 840000 | 280000  | 280000 | 280000 | 3     |
+----+------------+--------+---------+--------+--------+-------+
4 rows in set
```

## 7-7
```
> Household.where(item: '食費').where('outcome < any (select outcome from HouseholdArchive where item = "食費")')
  Household Load (0.5ms)  SELECT `Household`.* FROM `Household` WHERE `Household`.`item` = '食費' AND (outcome < any (select outcome from HouseholdArchive where item = "食費"))
+----+------------+------+----------------+--------+---------+
| id | day        | item | memo           | income | outcome |
+----+------------+------+----------------+--------+---------+
| 1  | 2013-02-03 | 食費 | コーヒーを購入 | 0      | 380     |
+----+------------+------+----------------+--------+---------+
1 row in set
```

## 7-8

## 7-9

## 7-10

## 7-11

## 8-1

## 8-2

## 8-3

## 8-4
```
> Householdx.joins(:item).select(:day, :name, :memo)
  Householdx Load (0.4ms)  SELECT `Householdx`.`day`, `name`, `Householdx`.`memo` FROM `Householdx` INNER JOIN `Items` ON `Items`.`id` = `Householdx`.`item_id`
+----+------------+--------------------+------+
| id | day        | memo               | name |
+----+------------+--------------------+------+
|    | 2013-02-10 | 1月の給料          | 給料 |
|    | 2013-02-03 | カフェラテを購入   | 食費 |
|    | 2013-02-05 | 昼食（日の出食堂） | 食費 |
+----+------------+--------------------+------+
3 rows in set
```

## 8-5

## 8-6
```
> Householdx.joins(:item).select(:day, :name, :memo)
  Householdx Load (0.4ms)  SELECT `Householdx`.`day`, `name`, `Householdx`.`memo` FROM `Householdx` INNER JOIN `Items` ON `Items`.`id` = `Householdx`.`item_id`
+----+------------+--------------------+------+
| id | day        | memo               | name |
+----+------------+--------------------+------+
|    | 2013-02-10 | 1月の給料          | 給料 |
|    | 2013-02-03 | カフェラテを購入   | 食費 |
|    | 2013-02-05 | 昼食（日の出食堂） | 食費 |
+----+------------+--------------------+------+
3 rows in set
```

## 8-7

## 8-8
```
> Householdx.joins(:item => :expense_category).select(:day, 'Items.name as "項目"', 'ExpenseCategories.name as "経費科目"')
  Householdx Load (0.6ms)  SELECT `Householdx`.`day`, Items.name as "項目", ExpenseCategories.name as "経費科目" FROM `Householdx` INNER JOIN `Items` ON `Items`.`id` = `Householdx`.`item_id` INNER JOIN `ExpenseCategories` ON `ExpenseCategories`.`id` = `Items`.`expense_category_id`
+----+------------+------+----------+
| id | day        | 項目 | 経費科目 |
+----+------------+------+----------+
|    | 2013-02-03 | 食費 | 支出     |
|    | 2013-02-05 | 食費 | 支出     |
|    | 2013-02-10 | 給料 | 収入     |
+----+------------+------+----------+
3 rows in set
```
