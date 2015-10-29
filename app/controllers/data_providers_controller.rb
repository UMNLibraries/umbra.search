class DataProvidersController < ApplicationController
  before_action :set_data_provider, only: [:show]

  def index

  end

  def show

  end

  private 

  def set_data_provider
    @data_provider = DataProvider.find(params[:id])
  end

end
