# == Schema Information
#
# Table name: TenpoShohin
#
#  tenpo_id  :string(4)        not null
#  tenpo_mei :string(200)      not null
#  shohin_id :string(4)        not null
#  suryo     :integer          not null
#

class TenpoShohin < ApplicationRecord
  self.table_name = :TenpoShohin

  belongs_to :shohin, foreign_key: :shohin_id
end
