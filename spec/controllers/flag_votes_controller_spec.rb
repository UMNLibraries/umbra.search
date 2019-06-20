require 'rails_helper'

describe FlagVotesController, :type => :controller do
  let(:flag_vote) { create :flag_vote }
  let(:record) { create :record }
  let(:editor) { create :user, :with_editor_role }
    before do
      sign_in editor
    end

  it "lists flag votes" do
    get :index
    puts response.inspect
    expect(response).to have_http_status(:ok)
  end

  # it "shows json display of flag vote records" do
  #   get :show, {:id => flag_vote.id, :format => :json}
  #   expect(response).to have_http_status(:ok)
  # end

  # it "it does not error out when a record is missing from the solr index" do
  #   flag_vote.record_id = 'This_record_does_not_exist'
  #   flag_vote.save
  #   get :show, {:id => flag_vote.id, :format => :json}
  #   expect(response).to have_http_status(:ok)
  # end
end