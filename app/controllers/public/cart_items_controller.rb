class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items

    # @cart_item = CartItem.new
    @total = 0
  end

  def create
    # 新しく追加するカートアイテム
    @cart_item = CartItem.new(cart_item_params)
    # すでにあるカートアイテム
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      # もし、新しく追加するカートアイテムとすでにあるカートアイテムのitem_idが一緒なら以下を実行
      if cart_item.item_id == @cart_item.item_id
        # 新しいカートアイテムの個数とすでにあるカートアイテムの個数を合計してnew_amountに代入する
        new_amount = cart_item.amount.to_i + @cart_item.amount.to_i
        # amountカラムだけupdateする
        cart_item.update(amount: new_amount)
        # 新しく作ってしまったカートアイテムを削除する
        @cart_item.destroy
        redirect_to cart_items_path
        # ここで処理を終わらせるためのreturn
        return
      end
    end
      # cart_item = CartItem.new(cart_item_params)
      # cart_itemを保存するときに自分のcustomer_idも保存しなければならないため、customer_idにはcurrent_customerのidが入るという記述
      @cart_item.customer_id = current_customer.id
      @cart_item.save
      redirect_to cart_items_path
  end

  # def find_byを使ったときの処理
    # 新しく追加するカートアイテム
    # @cart_item = CartItem.new(cart_item_params)
    # すでにあるカートアイテム
    # @cart_items = current_customer.cart_items
  #   if CartItem.find_by(item_id: @cart_items.item_id) == CartItem.find_by(item_id: @cart_item.item_id)
  # end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  # カートを空にする
  def destroy_all
    cart_items = CartItem.all
    cart_items.destroy_all
    redirect_to cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
