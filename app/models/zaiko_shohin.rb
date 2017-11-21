# == Schema Information
#
# Table name: ZaikoShohin
#
#  souko_id    :string(4)        not null
#  shohin_id   :string(4)        not null
#  zaiko_suryo :integer          not null
#

class ZaikoShohin < ApplicationRecord
  self.table_name = :ZaikoShohin

  belongs_to :shohin, foreign_key: :shohin_id
end
