class WidgetsController < ApplicationController
  protect_from_forgery :except => :search

  def index
    respond_to do |format|
      format.html
    end
  end

  def search
    @widget_params = widget_params
    respond_to do |format|
      format.js { render "bootstrap", formats: [:js] }
    end
  end

  def index
    @widget_params = widget_params
    respond_to do |format|
      # shows the widget generator form for the client
      format.html
      # deliver the bootstrapping Javascript
      format.js { render "bootstrap", formats: [:js] }
    end
  end

  def widget_params
    params.permit(:submit_text, :contributing_institution)
  end
end