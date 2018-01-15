class V1::TagsController < ApplicationController
  def index
    render json: Tag.all, status: :ok
  end

  def show
    render json: tag, status: :ok
  end

  def create
    render json: Tag.create!(tag_params), status: :created
  end

  def update
    tag.update!(tag_params)
    render json: tag, status: :ok
  end

  def destroy
    tag.destroy!
    head :ok
  end

  private
    def tag_params
      params.require(:tag).permit(:value, :description)
    end

    def tag
      Tag.find(params[:id])
    end
end
