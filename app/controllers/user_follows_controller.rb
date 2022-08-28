class UserFollowsController < ApplicationController
  before_action :set_user

  def create
    # current_user: ログイン中のユーザ
    # user コントローラーの follow メソッドを実行
    following = current_user.follow(@user)
    if following.save
      redirect_to @user, notice: t('controllers.follow.notice_create')
    else
      redirect_to @user, alert: t('controllers.follow.error_create')
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
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
