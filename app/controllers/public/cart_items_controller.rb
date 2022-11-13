class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.all
    @cart_item = CartItem.new
    @total = 0
  end

  def create
    cart_item = CartItem.new(cart_item_params)
    # cart_itemを保存するときに自分のcustomer_idも保存しなければならないため、customer_idにはcurrent_customerのidが入るという記述
    cart_item.customer_id = current_customer.id
    cart_item.save
    redirect_to cart_items_path
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_item_path
  end

  # カートを空にする
  def destroy_all
    cart_item = CartItem.all
    cart_item.destroy
    redirect_to cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
