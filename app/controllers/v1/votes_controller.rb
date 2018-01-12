class V1::VotesController < ApplicationController
  before_action :require_login
  before_action :get_voteable, only: [:index, :create]

  def index
    render json: @voteable.votes, status: :ok
  end

  def show
    render json: Vote.find(params[:id]), status: :ok
  end

  def create
    render json: @voteable.votes.where(user: current_user).create!(vote_params), status: :created
  end

  def update
    vote.update!(vote_params)
    render json: vote, status: :ok
  end

  def destroy
    vote.destroy!
    head :ok
  end

  private
    def get_voteable
      resource, id = request.path.split('/')[2, 3]
      @voteable = resource.singularize.classify.constantize.find(id)
    end

    def vote_params
      params.require(:vote).permit(:value)
    end

    def vote
      current_user.votes.find(params[:id])
    end
end
