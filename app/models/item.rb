class Item < ApplicationRecord

  has_many :order_details, dependent: :destroy
  has_many :cart_item, dependent: :destroy
  belongs_to :genre

  has_one_attached :image

end
