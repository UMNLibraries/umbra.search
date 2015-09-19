class WidgetsController < ApplicationController
  protect_from_forgery :except => :search

  def search
    @widget_params = widget_params
    respond_to do |format|
      # shows the widget generator form for the client
      format.html
      # deliver the bootstrapping Javascript
      format.js { render "bootstrap", formats: [:js] }
    end
  end

  def widget_params
    params.permit(:search_form_type, :submit_text)
  end
end