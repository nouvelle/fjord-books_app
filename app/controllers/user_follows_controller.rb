# frozen_string_literal: true

class UserFollowsController < ApplicationController
  before_action :set_user

  def create
    # current_user: ログイン中のユーザ
    # user models の follow メソッドを実行. ここでDBへの保存を実施
    if current_user.follow(@user)
      redirect_to @user, notice: t('controllers.follow.notice_create')
    else
      redirect_to @user, alert: t('controllers.follow.error_create')
    end
  end

  def destroy
    # user models の unfollow メソッドを実行. ここでDBからの削除を実施
    if current_user.unfollow(@user)
      redirect_to @user, notice: t('controllers.follow.notice_cancel')
    else
      redirect_to @user, alert: t('controllers.follow.error_cancel')
    end
  end

  private

  def set_user
    # フォローする対象のユーザ情報を取得
    @user = User.find(params[:follow_id])
  end
end
