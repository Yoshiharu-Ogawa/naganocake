class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new 
  end 
  
  def confirm
    @order = Order.new(order_params)
  end 
  
  def complete 
  end 
  
  def create 
  end 
  
  def index 
    @orders = Order.all
  end 
  
  def show 
    @order = Order.find(params[:id])
  end 
  
  private
  
  def order_params
    params.require(:order).permit(:delivery_postal_code, :delivery_address, :delivery_name, :total_payment, :freight, :payment_method, :order_status, :customer_id)
  end
  
end
