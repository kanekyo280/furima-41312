class Delivery < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :delivery_area
  belongs_to :saleslog

end
