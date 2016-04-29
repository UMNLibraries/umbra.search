require 'json'

class RecordsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update_tag_list
    authorize! :update, Record
    record.update_attribute(:tag_list, record_params['tag_list'])
    respond_to do |format|
      if record
        IndexRecord.new(record: record).index!
        SolrClient.commit
        format.json { render json: record.tag_list, status: :created, location: record }
      else
        format.json { render json: record.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def record
    Record.find_or_create_by(record_hash: record_params[:record_hash])
  end

  def record_params
    params.require(:record).permit(:tag_list, :record_hash)
  end
end
