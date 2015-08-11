require 'rails_helper'

feature 'Admin user creates a featured image' do
  scenario 'they see the new featured content page and it appears on the home page' do
    sign_in(:user, :with_editor_role)
    visit new_featured_content_path
    fill_in 'Title', with: 'This is a title'
    fill_in 'Description', with: 'Here is some description'
    check('Published')
    attach_file('featured_content_preview_image', "#{Rails.root}/spec/support/images/example.jpg")
    click_button 'Create Featured Content'
    expect(page).to have_content 'This is a title'
    expect(find(:css, '.featured-content-description').text).to have_content 'Here is some description'
    expect(page.find('.featured-content-image')['src']).to have_content 'example.jpg'
    visit root_path
    expect(page).to have_content 'This is a title'
  end
end