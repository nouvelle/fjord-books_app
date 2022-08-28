class UserFollowsController < ApplicationController
  before_action :set_user

  def create
    # current_user: ログイン中のユーザ
    # user コントローラーの follow メソッドを実行
    following = current_user.follow(@user)
    if following.save
      redirect_to @user, notice: 'ユーザーをフォローしました'
    else
      redirect_to @user, alert: 'ユーザーのフォローに失敗しました'
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      redirect_to @user, notice: 'ユーザーのフォローを解除しました'
    else
      redirect_to @user, alert: 'ユーザーのフォロー解除に失敗しました'
    end
  end

  private
  def set_user
    # フォローする対象のユーザ情報を取得
    @user = User.find(params[:follow_id])
  end
end
