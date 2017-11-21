class CreateTables2 < ActiveRecord::Migration[5.1]
  def change
    create_table 'Household' do |t|
      t.date 'day', null: false
      t.string :item, limit: 20,   null: false
      t.string :memo, limit: 100,  null: true
      t.integer :income,           null: false, default: 0
      t.integer :outcome,          null: false, default: 0
    end

    create_table 'HouseholdArchive' do |t|
      t.date 'day', null: false
      t.string :item, limit: 20,   null: false
      t.string :memo, limit: 100,  null: true
      t.integer :income,           null: false, default: 0
      t.integer :outcome,          null: false, default: 0
    end

    create_table 'Summary' do |t|
      t.string :item, limit: 20,   null: false
      t.integer :total,            null: false, default: 0
      t.integer :average,          null: false, default: 0
      t.integer :min,              null: false, default: 0
      t.integer :max,              null: false, default: 0
      t.integer :count,            null: false, default: 0
    end
  end
end
