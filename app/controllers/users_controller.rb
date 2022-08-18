# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :check_signed_in

  def index
    @users = User.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  private

  # サインインしていないユーザーはログインページへリダイレクト
  def check_signed_in
    unless user_signed_in?
      redirect_to '/users/sign_in'
    end
  end
end
