# == Schema Information
#
# Table name: Householdx
#
#  id      :integer          not null, primary key
#  day     :date             not null
#  item_id :integer
#  memo    :string(100)
#  income  :integer          default(0), not null
#  outcome :integer          default(0), not null
#

class Householdx < ApplicationRecord
  self.table_name = :Householdx
  belongs_to :item
end
