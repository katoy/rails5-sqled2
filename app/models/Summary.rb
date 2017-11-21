# == Schema Information
#
# Table name: Summary
#
#  id      :integer          not null, primary key
#  item    :string(20)       not null
#  total   :integer          default(0), not null
#  average :integer          default(0), not null
#  min     :integer          default(0), not null
#  max     :integer          default(0), not null
#  count   :integer          default(0), not null
#

class Summary < ApplicationRecord
  self.table_name = :Summary
end
