class LinksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @link = Link.new(link_params)

    if @link.save
      render json: { 'short': @link.encode }, status: 201
    else
      render json: { 'errors': @link.errors.full_messages }, status: 422
    end
  end

  def show
    @link = Link.decode(params[:code])

    if @link.nil?
      head 404
    else
      redirect_to @link.original
    end
  end

  private

  def link_params
    params.require(:link).permit(:original)
  end
end
