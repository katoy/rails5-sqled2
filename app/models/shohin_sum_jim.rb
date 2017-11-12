# == Schema Information
#
# Table name: ShohinSumJim
#
#  shohin_bunrui :string(32)       default("")
#  count_shohin  :integer          default(0), not null
#

class ShohinSumJim < ApplicationRecord
  self.table_name = :ShohinSumJim
end
