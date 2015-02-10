# require 'rails_helper'

# describe 'Editing a folder' do
#   let(:user) { create :user }
#   let(:document1) { SolrDocument.new(id: 'doc1', title_display: ['A title']) }
#   let(:document2) { SolrDocument.new(id: 'doc2', title_display: ['Another title']) }

#   let(:folder) { create(:folder, user: user) }
#   let!(:destination_folder) { create(:folder, user: user, name: 'Destination Folder') }
#   let(:bookmark1) { create(:bookmark, document: document1, user: user) }
#   let(:bookmark2) { create(:bookmark, document: document2, user: user) }
#   let!(:folder_item1) { create(:folder_item, bookmark: bookmark1, folder: folder) }
#   let!(:folder_item2) { create(:folder_item, bookmark: bookmark2, folder: folder) }

#   before do
#     Blacklight.solr.tap do |solr|
#       solr.delete_by_query("*:*", params: { commit: true })
#       solr.add [document1.to_h, document2.to_h]
#       solr.commit
#     end
#     sign_in user
#     visit blacklight_folders.folder_path(folder)
#     click_link "Edit Exhibit"
#   end

#   context 'when logged in' do
#     it 'Should allow me to update the exhibit name and description' do
#       expect(page).to have_field 'folder[items_attributes][0][position]', with: '1'
#       expect(page).to have_field 'folder[items_attributes][1][position]', with: '2'

#       fill_in 'folder[name]', with: 'I just met you'
#       fill_in 'folder[description]', with: 'and this is crazy'
#       click_button "Update Exhibit"

#       expect(page).to have_content "The exhibit was successfully updated"

#       # check that the second item is now the first.
#       expect(page).to have_selector ".folder-view:first-of-type h1", text: 'I just met you'
#       expect(page).to have_selector ".description", text: 'and this is crazy'
#     end

#     it 'Should allow me to update the description of exhibit items' do
#       expect(page).to have_field 'folder[items_attributes][0][description]', with: ''

#       fill_in 'folder[items_attributes][0][description]', with: 'Love Me Harder'
#       click_button "Update Exhibit"

#       expect(page).to have_content "The exhibit was successfully updated"

#       # check that the second item is now the first.
#       expect(page).to have_selector "#documents .folder-gallery-item .folder-item-description", text: 'Love Me Harder'
#     end

#     it 'Should allow me to update the order of the exhibit items' do
#       expect(page).to have_field 'folder[items_attributes][0][position]', with: '1'
#       expect(page).to have_field 'folder[items_attributes][1][position]', with: '2'

#       fill_in 'folder[items_attributes][1][position]', with: '1'

#       click_button "Update Exhibit"

#       expect(page).to have_content "The exhibit was successfully updated"

#       # check that the second item is now the first.
#       expect(page).to have_selector "#documents .folder-gallery-item .folder-item-title", text: 'Another title'
#     end

#     it "should allow me to remove exhibit items" do
#       within "#documents li:first-of-type" do
#         check 'Delete'
#       end
#       click_button "Update Exhibit"

#       expect(page).to have_content "The exhibit was successfully updated"
#       expect(page).not_to have_content "A title"
#       expect(page).to have_selector "#documents .folder-gallery-item", count: 1
#     end

#     it "should allow me to move items from one exhibit to another" do
#       within "#documents li:first-of-type" do
#         select 'Destination Folder', from: 'folder[items_attributes][0][folder_id]'
#       end
#       click_button "Update Exhibit"

#       expect(page).to have_content "The exhibit was successfully updated"
#       expect(page).not_to have_content "A title"
#       expect(page).to have_selector "#documents .folder-gallery-item", count: 1

#       click_link 'Destination Folder'
#       within '#documents' do
#         expect(page).to have_content "A title"
#       end
#     end
#   end
# end

