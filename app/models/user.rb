# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar

  # フォローした・されたの関係（どちらも UserFollow モデルから取得するが、どっちの Follow か分けるために名前を分けて２つ記載する）

  # フォローする
  has_many :user_follows, class_name: 'UserFollow', dependent: :destroy
  # user_follows テーブルの follow_id(follow) を参考にして、架空の followings モデルにアクセスする
  # これにより、user.followings と書くことで、user が中間テーブル user_follows にアクセスし、
  # user_follows の 1つ1つの follow_id から「フォローしている User 達」を取得できるようになる
  has_many :followings, through: :user_follows, source: :follow

  # フォローされる
  # 架空の reverse_of_user_follows テーブルの実態は UserFollow。
  # user_follows テーブルにアクセスする時、follow_id をキーにアクセスする
  has_many :reverse_of_user_follows, class_name: 'UserFollow', foreign_key: 'follow_id', dependent: :destroy, inverse_of: :user_follows
  # user_follows テーブルの user_id(user) を参考にして、架空の followers モデルにアクセスする
  # これにより、user.followers と書くことで、user が中間テーブル reverse_of_user_follows にアクセスし、
  # user_follows の 1つ1つの user_id から「自分をフォローしている User 達」を取得できるようになる
  has_many :followers, through: :reverse_of_user_follows, source: :user

  # フォローしたときの処理
  def follow(user)
    # self は自分自身
    # user が自分自身ではない場合は登録
    user_follows.find_or_create_by(follow_id: user.id) if self != user
  end

  # フォローを外すときの処理
  def unfollow(user)
    user_follows = self.user_follows.find_by(follow_id: user.id)
    user_follows&.destroy
  end

  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
end
