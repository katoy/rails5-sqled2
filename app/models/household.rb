# == Schema Information
#
# Table name: Household
#
#  id      :integer          not null, primary key
#  day     :date             not null
#  item    :string(20)       not null
#  memo    :string(100)
#  income  :integer          default(0), not null
#  outcome :integer          default(0), not null
#

class Household < ApplicationRecord
  self.table_name = :Household
end
