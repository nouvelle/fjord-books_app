# frozen_string_literal: true

class UserFollow < ApplicationRecord
  # 架空の follow テーブルの実態は User
  belongs_to :user
  belongs_to :follow, class_name: 'User'

  validates :user_id, presence: true
  validates :follow_id, presence: true
end
