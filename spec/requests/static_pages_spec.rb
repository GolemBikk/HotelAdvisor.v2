require 'rails_helper'

RSpec.describe "StaticPages", type: :feature do
  describe "GET /static_pages/home" do
    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title('Home')
    end
    it "should have the content 'Home page'" do
      visit '/static_pages/home'
      expect(page).to have_content('Home page')
    end
  end

  describe "GET /static_pages/help" do
    it "should have the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title('Help')
    end
    it "should have the content 'Help page'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help page')
    end
  end

  describe "GET /static_pages/about" do
    it "should have the title 'About us'" do
      visit '/static_pages/about'
      expect(page).to have_title('About us')
    end
    it "should have the content 'About us page'" do
      visit '/static_pages/about'
      expect(page).to have_content('About us page')
    end
  end
end
