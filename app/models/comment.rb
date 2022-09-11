# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  validates :content, presence: true

  def user_name
    user = User.find(user_id)
    if user.name.empty?
      user.email
    else
      user.name
    end
  end
end
