class CreateViews < ActiveRecord::Migration[5.1]
  def self.up
    execute <<-SQL
      CREATE VIEW ShohinSum (shohin_bunrui, count_shohin)
      AS
      SELECT shohin_bunrui, count(*)
      FROM Shohin
      GROUP BY shohin_bunrui;
    SQL

    execute <<-SQL
      CREATE VIEW ShohinSumJim (shohin_bunrui, count_shohin)
      AS
      SELECT shohin_bunrui, count(*)
      FROM ShohinSum
      WHERE shohin_bunrui = '事務用品'
    SQL
  end

  def self.down
    execute <<-SQL
      DROP VIEW ShohinSum;
    SQL

    execute <<-SQL
      DROP VIEW ShohinSumJim;
    SQL
  end
end
