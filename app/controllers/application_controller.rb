# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後に遷移するURL
  def after_sign_in_path_for(resource)
    '/books'
    # "/users/#{current_user.id}"
  end

  # ログアウト後に遷移するURL
  def after_sign_out_path_for(resource)
    '/users/sign_in'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:post_code, :address, :introduction])
    devise_parameter_sanitizer.permit(:account_update, keys: [:post_code, :address, :introduction])
  end
end
