class SearchesController < ApplicationController
  def index

  end


  def new
    @search = Search.new
  end

  def create
    @search = Search.create(search_params)
    redirect_to searches_path
  end

  private
  def search_params
    params.require(:search).permit(
    :position,
    :city,
    :state,
    :zip,
    :industry,
    :company
    )
  end
end
