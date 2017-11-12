# == Schema Information
#
# Table name: Chars
#
#  chr :string(3)        not null, primary key
#

class Char < ApplicationRecord
  self.table_name = :Chars
end
