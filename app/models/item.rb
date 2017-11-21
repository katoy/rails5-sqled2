# == Schema Information
#
# Table name: Items
#
#  id                  :integer          not null, primary key
#  name                :string(20)       not null
#  memo                :string(100)
#  expense_category_id :integer
#

class Item < ApplicationRecord
  self.table_name = :Items

  has_many :householdxex
  belongs_to :expense_category
end
