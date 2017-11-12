class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table 'Shohin',
                 primary_key: [:shohin_id] do |t|
      t.string 'shohin_id', limit: 4
      t.string 'shohin_mei', limit: 100, null: false
      t.string 'shohin_bunrui', limit: 32, null: false
      t.integer 'hanbai_tanka'
      t.integer 'shiire_tanka'
      t.date 'torokubi'
    end

    create_table 'Shohin2',
                 primary_key: [:shohin_id] do |t|
      t.string 'shohin_id', limit: 4
      t.string 'shohin_mei', limit: 100, null: false
      t.string 'shohin_bunrui', limit: 32, null: false
      t.integer 'hanbai_tanka'
      t.integer 'shiire_tanka'
      t.date 'torokubi'
    end

    create_table 'ShohinCopy',
                 primary_key: [:shohin_id] do |t|
      t.string 'shohin_id', limit: 4
      t.string 'shohin_mei', limit: 100, null: false
      t.string 'shohin_bunrui', limit: 32, null: false
      t.integer 'hanbai_tanka'
      t.integer 'shiire_tanka'
      t.date 'torokubi'
    end

    create_table 'ShohinIns',
                 primary_key: [:shohin_id] do |t|
      t.string 'shohin_id', limit: 4
      t.string 'shohin_mei', limit: 100, null: false
      t.string 'shohin_bunrui', limit: 32, null: false
      t.integer 'hanbai_tanka'
      t.integer 'shiire_tanka', default: 0
      t.date 'torokubi'
    end

    create_table 'Chars',
                 primary_key: [:chr] do |t|
      t.string 'chr', limit: 3, null: false
    end

    create_table 'TenpoShohin',
                 primary_key: %i[tenpo_id shohin_id] do |t|
      t.string 'tenpo_id',  limit: 4,   null: false
      t.string 'tenpo_mei', limit: 200, null: false
      t.string 'shohin_id', limit: 4,   null: false
      t.integer 'suryo',                null: false
    end

    create_table 'ZaikoShohin',
                 primary_key: %i[shohin_id souko_id] do |t|
      t.string 'souko_id',  limit: 4,   null: false
      t.string 'shohin_id', limit: 4,   null: false
      t.integer 'zaiko_suryo',          null: false
    end
  end
end
