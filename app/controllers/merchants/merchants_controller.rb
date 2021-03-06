module Merchants
  class MerchantsController < ApplicationController
    skip_before_action :require_valid_merchant!
    skip_before_action :verify_authenticity_token
    before_action :reset_session

    def new
      @merchant = Merchant.new
    end

    def create
      @merchant = Merchant.new(merchant_params)

      if @merchant.save
        session[:merchant_id] = @merchant.id
        flash[:success] =  'You have successfully created an account!'
        redirect_to root_path
      else
        render :new
      end
    end

    def merchant_params
      params.require(:merchant).permit(:name, :email, :password, :password_confirmation)
    end
  end
end
