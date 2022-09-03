# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # ユーザ情報編集後に遷移するURL
  def after_update_path_for(_)
    '/books'
  end
end
