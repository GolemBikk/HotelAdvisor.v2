require 'rails_helper'

RSpec.describe 'StaticPages', type: :feature do
  subject { page }

  shared_examples_for 'All static pages' do
    it { should have_selector('h1', text: heading) }
    it { should have_title(page_title) }
  end

  describe 'GET /static_pages/home' do
    before { visit home_path }
    let(:heading) { 'Home page' }
    let(:page_title) { 'Home' }
  end

  describe 'GET /static_pages/help' do
    before { visit help_path }
    let(:heading) { 'Help page' }
    let(:page_title) { 'Help' }
  end

  describe 'GET /static_pages/about' do
    before { visit about_path }
    let(:heading) { 'About us page' }
    let(:page_title) { 'About us' }
  end

  describe 'GET /static_pages/contact' do
    before { visit contact_path }
    let(:heading) { 'Contact page' }
    let(:page_title) { 'Contact' }
  end

  describe 'GET /' do
    before { visit root_path }
    click_link 'Home'
    expect(page).to have_title('Home')
    click_link 'About'
    expect(page).to have_title('About us')
    click_link 'Help'
    expect(page).to have_title('Help')
    click_link 'Contact'
    expect(page).to have_title('Contact')
  end
end
