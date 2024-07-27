class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_status
  belongs_to :postage_payer
  belongs_to :delivery_area
  belongs_to :delivery_day
  belongs_to :user

  has_one_attached :image

with_options presence: true do
    validates :product_name
    validates :description
    validates :image

  with_options numericality: { other_than: 1 , message: "can't be blank"} do
    validates :category_id
    validates :product_status_id
    validates :postage_payer_id
    validates :delivery_area_id
    validates :delivery_day_id
  end

    validates :price,  numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end

end
