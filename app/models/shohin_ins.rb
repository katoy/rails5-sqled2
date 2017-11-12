# == Schema Information
#
# Table name: ShohinIns
#
#  shohin_id     :string(4)        not null, primary key
#  shohin_mei    :string(100)      not null
#  shohin_bunrui :string(32)       not null
#  hanbai_tanka  :integer
#  shiire_tanka  :integer          default(0)
#  torokubi      :date
#

class ShohinIns < ApplicationRecord
  self.table_name = :ShohinIns
end
