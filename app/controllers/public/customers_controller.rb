class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    customer = current_customer
    customer.update(customer_params)
    redirect_to customer_path(current_customer.id)
  end

  # 顧客の退会確認画面
  def unsubscribe
  end

  # 顧客の退会機能
  def reject_customer
    customer = current_customer
    customer.update(is_deleted: true)
    reset_session
    redirect_to customers_unsubscribe_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_deleted)
  end

end
