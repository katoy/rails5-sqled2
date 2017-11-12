# == Schema Information
#
# Table name: Shohin
#
#  shohin_id     :string(4)        not null, primary key
#  shohin_mei    :string(100)      not null
#  shohin_bunrui :string(32)       not null
#  hanbai_tanka  :integer
#  shiire_tanka  :integer
#  torokubi      :date
#

class Shohin < ApplicationRecord
  self.table_name = :Shohin

  has_many :tenpo_shohins, foreign_key: :shohin_id
  has_many :zaiko_shohins, foreign_key: :shohin_id
end
