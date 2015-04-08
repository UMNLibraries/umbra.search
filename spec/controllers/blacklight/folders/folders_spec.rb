require 'rails_helper'

describe Blacklight::Folders::FoldersController do
  routes { Blacklight::Folders::Engine.routes }
  let(:user) { create(:user) }
  let(:my_private_folder) { create(:private_folder, user: user) }
  let(:my_public_folder)  { create(:public_folder, user: user, name: "My First Folder") }

  describe '#add_bookmarks' do
    context "to someone elses folder" do
      it 'denies access' do
        patch :add_bookmarks, folder: { id: my_public_folder.id }, document_ids: '123'
        expect(response).to redirect_to("/users/sign_in")
      end
    end

    context "to a default folder" do
      it 'adds bookmarks to the folder and persists the user' do
        @request.env['HTTP_REFERER'] = 'http://test.com'
        # the '0' folder is the default folder
        patch :add_bookmarks, folder: { id: 0 }, document_ids: '123, 456'

        expect(assigns(:folder).user).to be_persisted
        expect(assigns(:folder).user).to be_guest
        expect(flash[:notice]).to eq "Added documents to Default Exhibit"
        expect(assigns(:folder).bookmarks.map(&:document_id)).to match_array ['123', '456']
        expect(response).to redirect_to :back
      end
    end
  end

end