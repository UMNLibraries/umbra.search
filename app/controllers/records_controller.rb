require 'json'

class RecordsController < ApplicationController
  before_filter :restrict_access
  skip_before_action :verify_authenticity_token
  def upsert
    updated = UpsertRecords.call(record_params.fetch('records', []))
    render :json => {:status => updated }
  end

  private
  
  def record_params
    params.permit(:api_key, :records => [:record_hash, :ingest_hash, :ingest_name, :metadata])
  end

  def restrict_access
    api_key = ApiKey.find_by_access_token(record_params[:api_key])
    head :unauthorized unless api_key
  end
end
