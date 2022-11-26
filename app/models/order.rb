class Order < ApplicationRecord

  has_many :order_details, dependent: :destroy

  belongs_to :customer

  def subtotal
    item.add_tax_price * amount
  end

  def order_detail_subtotal
    price_including_tax * quantity
  end

  enum payment_method: {credit_card: 0, transfer: 1 }
  enum order_status:{payment_waiting: 0, payment_confirmation: 1, in_production: 2, delivery_preparation: 3, delivered: 4 }

end
