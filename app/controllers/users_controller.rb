# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @followings = UserFollow.where(user_id: params[:id])
    @followers = UserFollow.where(follow_id: params[:id])
  end

  def followings
    @users = User.find(params[:user_id])
    @user_id = @users.id
  end

  def followers
    @users = User.find(params[:user_id])
    @user_id = @users.id
  end
end
