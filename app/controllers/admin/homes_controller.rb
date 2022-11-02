class Admin::HomesController < ApplicationController

  def top
    @orders = Order.all

    @customers = Customer.all

    @order_details = OrderDetail.all

  end

end
