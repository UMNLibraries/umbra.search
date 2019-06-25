require 'rails_helper'

describe 'Browsing Facets', js: true do
  it "expands the keyword facet more link with an expanded list of clickable facets" do
    visit '/catalog?utf8=✓&search_field=all_fields&q='
    find(:xpath, '//*[@id="facet-keywords_ssim"]/div/ul/li[5]/div/a').click
    find(:xpath, '//*[@id="ajax-modal"]/div/div/div[3]/div/ul/li[19]/span[1]/a').click
    sleep 1
    expect(page).to have_content 'Formal studio portrait of Ralph Metcalfe, 1932'
  end
end
