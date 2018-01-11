class V1::VotesController < ApplicationController
  def index
    @votes = Vote.all
    render json: @votes, status: :ok
  end

  def show
    @vote = Vote.find(params[:id])
    render json: @vote, status: :ok
  end
end
