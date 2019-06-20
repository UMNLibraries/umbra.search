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
    expect(response).to have_http_status(:ok)
  end
end