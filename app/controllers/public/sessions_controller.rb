# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  #before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :customer_state, only: [:create]

  def after_sign_up_path_for(resource)
    customers_my_page_path
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  # 退会しているかを判断するメソッド
  def customer_state
    ## 【処理内容1】 入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
    ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @customer.valid_password?(params[:customer][:password])
      ## 【処理内容3】そのアカウントのis_deletedの中身（trueかfalse)を1件取得
      @is_deleted = @customer.is_deleted
      ## trueだった場合、退会しているのでサインアップ画面に遷移する
      if @is_deleted == true
        redirect_to 'new_registration_path'
      end
      ## falseだった場合、退会していないのでそのままcreateアクションを実行させる
      if @is_deleted == false

      end
    end
  end



end
