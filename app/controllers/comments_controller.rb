# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  def show; end

  def new
    @comment = Comment.new
  end

  def edit; end

  def create
    @comment = @commentable.comments.build(params.require(:comment).permit(:content))
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render :new
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = @commentable.comment.find(params[:id])
  end
end
