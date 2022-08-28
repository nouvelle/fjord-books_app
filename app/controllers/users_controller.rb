# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @followings = UserFollow.where(user_id: params[:id])
    @followers = UserFollow.where(follow_id: params[:id])
    [@user, @followings, @followers]
  end

  def followings
    followings = UserFollow.where(user_id: params[:user_id])
    follow_ids = []
    followings.each do |following|
      follow_ids.push(following.follow_id)
    end
    @users = User.where('id IN (?)', follow_ids).with_attached_avatar
    @user_id = params[:user_id]
    [@users, @user_id]
  end

  def followers
    followers = UserFollow.where(follow_id: params[:user_id])
    follower_ids = []
    followers.each do |follower|
      follower_ids.push(follower.user_id)
    end
    @users = User.where('id IN (?)', follower_ids).with_attached_avatar
    @user_id = params[:user_id]
    [@users, @user_id]
  end
end
