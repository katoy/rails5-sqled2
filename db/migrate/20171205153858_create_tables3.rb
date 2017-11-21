class CreateTables3 < ActiveRecord::Migration[5.1]
  def change
    create_table 'Householdx' do |t|
      t.date 'day', null: false
      t.integer :item_id,          null: true
      t.string :memo, limit: 100,  null: true
      t.integer :income,           null: false, default: 0
      t.integer :outcome,          null: false, default: 0
    end

    create_table 'Items' do |t|
      t.string :name, limit: 20,   null: false
      t.string :memo, limit: 100,  null: true
      t.integer :expense_category_id, null: true
    end

    create_table 'ExpenseCategories' do |t|
      t.string :name, limit: 20,   null: false
    end
  end
end
