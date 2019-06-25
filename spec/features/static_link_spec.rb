  require 'rails_helper'

context 'when visiting the site as a unauthenticated user', js: true do
  it 'resolves footer links when they are clicked' do
    visit '/'
    find(:xpath, '//*[@id="footer"]/div/div/div[2]/ul/li[1]/a').click
    expect(page).to have_content 'About Umbra'
    visit '/'
    find(:xpath, '//*[@id="footer"]/div/div/div[2]/ul/li[2]/a').click
    expect(page).to have_content 'Get Involved'
    visit '/'
    find(:xpath, '//*[@id="footer"]/div/div/div[2]/ul/li[3]/a').click
    expect(page).to have_content 'Contact Us'
    visit '/'
    find(:xpath, '//*[@id="footer"]/div/div/div[2]/ul/li[4]/a').click
    expect(page).to have_content 'Welcome to #UmbraSearch'
  end

  it 'resolves help links when they are clicked' do
    visit '/'
    find(:xpath, '//*[@id="primary-nav"]/li[2]/a').click
    find(:xpath, '//*[@id="about-nav-link"]').click
    expect(page).to have_content 'Contact Us'
  end
end
