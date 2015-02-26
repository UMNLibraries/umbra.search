require 'rails_helper'


context 'when visiting the site as a unauthenticated user' do

    it 'resolves footer links when they are clicked' do
      pages = {
        "about-foot-link" => "About Umbra",
        "participate-foot-link" => "How to Participate",
        "contact-foot-link" => "Contact Us",
        "umlib-foot-link" => "Libraries",
        "penumbra-foot-link" => "Penumbra Theatre",
        "imls-foot-link" => "Institute of Museum and Library Services",
        "dd-foot-link" => "Doris Duke Charitable Foundation"
      }
      pages.each do |link, content|
        check_static_page(link, content)
      end
    end

    it 'resolves help links when they are clicked' do
      pages = {
        "about-nav-link" => "About Umbra",
        "participate-nav-link" => "How to Participate",
        "contact-nav-link" => "Contact Us"
      }
      pages.each do |link, content|
        check_static_page(link, content)
      end
    end

    def check_static_page(link, content)
      visit "/"
      click_link link
      expect(page).to have_content(content)
    end

end
