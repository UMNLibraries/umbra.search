require 'rails_helper'

feature 'Admin user creates a featured image' do
  scenario 'they see the new featured content page and it appears on the home page' do
    sign_in(:user, :with_editor_role)
    visit new_featured_content_path
    fill_in 'Title', with: 'This is a title'
    check('Published')
    attach_file('featured_content_preview_image', "#{Rails.root}/spec/support/images/example.jpg")
    click_button 'Create Featured Content'
    expect(page).to have_content 'This is a title'
    expect(page.find('.featured-content-image')['src']).to have_content 'example.jpg'
    visit root_path
    expect(page).to have_content 'This is a title'
  end
end