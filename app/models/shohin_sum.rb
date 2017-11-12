# == Schema Information
#
# Table name: ShohinSum
#
#  shohin_bunrui :string(32)       not null
#  count_shohin  :integer          default(0), not null
#

class ShohinSum < ApplicationRecord
  self.table_name = :ShohinSum
end
