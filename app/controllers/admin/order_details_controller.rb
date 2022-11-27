class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = @order_detail.order
    @order_details = @order.order_details.all


    # 制作ステータスが製作中だったとき、注文ステータスを製作中に更新する
    if @order_detail.production_status == 'in_production'
      #@order.order_status = 2
      @order.update(order_status: 2)
    end

    if @order_details.count == @order_details.where(production_status: 'production_complete').count
      @order.update(order_status: 3)
    end

    redirect_to admin_order_path(@order_detail.order.id)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:price_including_tax, :quantity, :production_status )
  end

  def order_params
    params.require(:order).permit(:order_status )
  end

end
