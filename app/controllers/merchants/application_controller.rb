module Merchants

  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :require_valid_merchant!
    layout 'application'

    def current_merchant
      if !session[:merchant_id].blank?
        @merchant ||= Merchant.find(session[:merchant_id])
      end
    end

    def require_valid_merchant!
      if current_merchant.nil?
        flash[:error] = 'You must be logged in to access that page!'
        redirect_to merchants_login_path
      end
    end
  end
end
