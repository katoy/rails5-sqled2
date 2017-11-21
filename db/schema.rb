# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171205153858) do

  create_table "Chars", primary_key: "chr", id: :string, limit: 3, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
  end

  create_table "ExpenseCategories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 20, null: false
  end

  create_table "Household", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date "day", null: false
    t.string "item", limit: 20, null: false
    t.string "memo", limit: 100
    t.integer "income", default: 0, null: false
    t.integer "outcome", default: 0, null: false
  end

  create_table "HouseholdArchive", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date "day", null: false
    t.string "item", limit: 20, null: false
    t.string "memo", limit: 100
    t.integer "income", default: 0, null: false
    t.integer "outcome", default: 0, null: false
  end

  create_table "Householdx", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date "day", null: false
    t.integer "item_id"
    t.string "memo", limit: 100
    t.integer "income", default: 0, null: false
    t.integer "outcome", default: 0, null: false
  end

  create_table "Items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 20, null: false
    t.string "memo", limit: 100
    t.integer "expense_category_id"
  end

  create_table "Shohin", primary_key: "shohin_id", id: :string, limit: 4, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "shohin_mei", limit: 100, null: false
    t.string "shohin_bunrui", limit: 32, null: false
    t.integer "hanbai_tanka"
    t.integer "shiire_tanka"
    t.date "torokubi"
  end

  create_table "Shohin2", primary_key: "shohin_id", id: :string, limit: 4, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "shohin_mei", limit: 100, null: false
    t.string "shohin_bunrui", limit: 32, null: false
    t.integer "hanbai_tanka"
    t.integer "shiire_tanka"
    t.date "torokubi"
  end

  create_table "ShohinCopy", primary_key: "shohin_id", id: :string, limit: 4, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "shohin_mei", limit: 100, null: false
    t.string "shohin_bunrui", limit: 32, null: false
    t.integer "hanbai_tanka"
    t.integer "shiire_tanka"
    t.date "torokubi"
  end

  create_table "ShohinIns", primary_key: "shohin_id", id: :string, limit: 4, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "shohin_mei", limit: 100, null: false
    t.string "shohin_bunrui", limit: 32, null: false
    t.integer "hanbai_tanka"
    t.integer "shiire_tanka", default: 0
    t.date "torokubi"
  end

  create_table "Summary", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "item", limit: 20, null: false
    t.integer "total", default: 0, null: false
    t.integer "average", default: 0, null: false
    t.integer "min", default: 0, null: false
    t.integer "max", default: 0, null: false
    t.integer "count", default: 0, null: false
  end

  create_table "TenpoShohin", primary_key: ["tenpo_id", "shohin_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "tenpo_id", limit: 4, null: false
    t.string "tenpo_mei", limit: 200, null: false
    t.string "shohin_id", limit: 4, null: false
    t.integer "suryo", null: false
  end

  create_table "ZaikoShohin", primary_key: ["shohin_id", "souko_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "souko_id", limit: 4, null: false
    t.string "shohin_id", limit: 4, null: false
    t.integer "zaiko_suryo", null: false
  end

end
