class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = 0
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to admin_order_path(order.id)
  end

  private

  def order_params
    params.require(:order).permit(:delivery_postal_code, :delivery_address, :delivery_name, :total_payment, :freight, :payment_method, :order_status )
  end

end
