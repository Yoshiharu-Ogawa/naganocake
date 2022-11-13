class Order < ApplicationRecord

  has_many :order_details, dependent: :destroy

  belongs_to :customer

  enum payment_method: {credit_card: 0, transfer: 1 }
  enum order_status:{payment_waiting: 0, payment_confirmation: 1, in_production: 2, delivery_preparation: 3, delivered: 4 }

end
