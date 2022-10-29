class Item < ApplicationRecord

  has_many :order_details, dependent: :destroy
  has_many :cart_item, dependent: :destroy

  has_one_attached :image

# 消費税を加えた商品価格 .roundを使って、小数点を切り上げ
  def add_tax_price
    (self.price * 1.08).round
  end

end
