class V1::CommentsController < ApplicationController
  before_action :require_login
  before_action :get_commentable, only: [:index, :create]

  def index
    render json: @commentable.comments, status: :ok
  end

  def show
    render json: Comment.find(params[:id]), status: :ok
  end

  def create
    render json: @commentable.comments.where(user: current_user).create!(comment_params), status: :created
  end

  def update
    comment.update!(comment_params)
    render json: comment, status: :ok
  end

  def destroy
    comment.destroy!
    head :ok
  end

  private
    def get_commentable
      resource, id = request.path.split('/')[2, 3]
      @commentable = resource.singularize.classify.constantize.find(id)
    end

    def comment_params
      params.require(:comment).permit(:text)
    end

    def comment
      current_user.comments.find(params[:id])
    end
end
