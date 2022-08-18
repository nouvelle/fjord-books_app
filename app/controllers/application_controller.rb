# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後に遷移するURL
  def after_sign_in_path_for(_)
    '/books'
  end

  # ログアウト後に遷移するURL
  def after_sign_out_path_for(_)
    '/users/sign_in'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[post_code address introduction])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[post_code address introduction])
  end
end
