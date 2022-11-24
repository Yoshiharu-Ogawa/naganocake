class Public::OrdersController < ApplicationController

  def new
    @order = Order.new

  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @total = 0
    if params[:order][:select_address] == "0"
      @order.delivery_postal_code = current_customer.postal_code
      @order.delivery_address = current_customer.address
      @order.delivery_name = current_customer.last_name + current_customer.first_name
    # elsif params[:order][:select_adderss] == 1
    elsif params[:order][:select_address] == "2"
      @order.delivery_postal_code = params[:order][:delivery_postal_code]
      @order.delivery_address = params[:order][:delivery_address]
      @order.delivery_name = params[:order][:delivery_name]
    end

  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    # カートアイテム内の情報をOrderDetailに保存する必要がある
    @cart_items = current_customer.cart_items
    # カート内には複数のアイテム情報があるので、eachで一つずつ分ける
    # カートアイテム内のそれぞれのデータをOrderDetailのデータカラムに保存する
    @cart_items.each do |cart_item|
      # OrderDetailに保存するための空の箱
      order_detail = OrderDetail.new
      # OrderDetailに渡すorder_idは、上の動作で作成したOrderのIDを格納
      order_detail.order_id = @order.id
      # カート内にある複数の商品ID
      order_detail.item_id = cart_item.item_id
      # Orderでは商品個数がamountだったが、OrderDetailではquantity
      order_detail.quantity = cart_item.amount
      # Orderでは商品一つの税込み価格がモデルにitem.add_tax_priceであったが、OrderDetailではprice_including_taxというカラムに入れる
      order_detail.price_including_tax = cart_item.item.add_tax_price
      # OrderDetailでは、あとproduction_statusというカラムがあるが、初期値0で設定され送っているので、データの置換は必要なし
      order_detail.save
    end
    # カートの商品を移し替えたので、current_customerのカート内情報を全削除
    @cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def complete
  end

  def index
    @orders = current_customer.orders
    # @cart_items = current_customer.cart_items
    #@orders.each do |order|
    #@order_details = order.order_details
    #end
  end

  def show
    @order = Order.find(params[:id])
    @total = 0
    @order_details = @order.order_details
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :delivery_postal_code, :delivery_address, :delivery_name, :total_payment, :freight, :payment_method, :order_status, :customer_id,)
    # params.require(:order).permit(:payment_method, :delivery_postal_code, :delivery_address,:delivery_name)
  end

end
