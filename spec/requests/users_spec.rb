require 'rails_helper'

RSpec.describe "Users", type: :feature do
  subject { page }

  describe "GET /users/sing_in" do
    before { visit new_user_session_path}
    it { should have_title 'Log in'}
    it { should have_content 'Log in'}
  end

  describe "GET /users/sing_up" do
    before { visit new_user_registration_path}
    it { should have_title 'Sing up'}
    it { should have_content 'Sign up'}
  end

  describe "GET /users/edit" do
    before { visit edit_user_registration_path}
    it { should have_title 'Edit account'}
    it { should have_content 'Edit'}
  end
end
