# == Schema Information
#
# Table name: ExpenseCategories
#
#  id   :integer          not null, primary key
#  name :string(20)       not null
#

class ExpenseCategory < ApplicationRecord
  self.table_name = :ExpenseCategories

  has_many :items
end
