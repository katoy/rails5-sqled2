# == Schema Information
#
# Table name: ShohinCopy
#
#  shohin_id     :string(4)        not null, primary key
#  shohin_mei    :string(100)      not null
#  shohin_bunrui :string(32)       not null
#  hanbai_tanka  :integer
#  shiire_tanka  :integer
#  torokubi      :date
#

class ShohinCopy < ApplicationRecord
  self.table_name = :ShohinCopy
end
