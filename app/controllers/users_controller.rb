# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @following = UserFollow.where(user_id: params[:id])
    @follower = UserFollow.where(follow_id: params[:id])
    [@user, @following, @follower]
  end
end
