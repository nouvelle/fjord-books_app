# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # ログイン後に遷移するURL
  def after_sign_in_path_for(resource)
    '/books'
  end

  # ログアウト後に遷移するURL
  def after_sign_out_path_for(resource)
    '/users/sign_in'
  end
end
