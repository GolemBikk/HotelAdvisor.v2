require 'rails_helper'

RSpec.describe "StaticPages", type: :feature do
  subject { page }

  describe "GET /static_pages/home" do
    before { visit home_path }
    it { should have_title 'Home' }
    it { should have_content 'Home page'}
  end

  describe "GET /static_pages/help" do
    before { visit help_path }
    it { should have_title 'Help' }
    it { should have_content 'Help page'}
  end

  describe "GET /static_pages/about" do
    before { visit about_path }
    it { should have_title 'About us' }
    it { should have_content 'About us page'}
  end

  describe "GET /static_pages/contact" do
    before { visit contact_path }
    it { should have_title 'Contact' }
    it { should have_content 'Contact page'}
  end
end
