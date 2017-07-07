require 'rails_helper'

RSpec.describe 'AuthenticationPages', type: :feature do
  subject { page }

  describe 'GET /users/sing_in' do
    before { visit new_user_session_path}

    it { should have_title 'Log in'}
    it { should have_content 'Log in'}

    let(:submit) { 'Log in' }

    describe 'with invalid information' do
      it 'should not create a user' do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe 'after submission' do
        before { click_button submit }

        it { should have_title('Log in') }
        it { should have_content('Invalid') }
      end

      describe 'after visiting another page' do
        before { click_link 'Home' }
        it { should_not have_content('Invalid') }
      end
    end

    let(:user) { FactoryGirl.create(:user) }

    describe 'with valid information' do
      before { valid_sign_in(user) }

      it { should have_title(user.first_name) }
      it { should have_link('Users',    href: users_path) }
      it { should have_link('Profile',    href: user_path(user)) }
      it { should have_link('Settings',   href: edit_user_registration_path(user)) }
      it { should have_link('Log out',    href: destroy_user_session_path) }
      it { should_not have_link('Sign in', href: new_user_session_path) }
    end

    describe 'when attempting to visit a protected page' do
      before do
        visit edit_user_registration_path
        valid_sign_in(user)
      end

      describe 'after signing in' do
        it { should have_title('Edit profile')}
      end
    end
  end

  describe 'DELETE /users/sign_out' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit new_user_session_path
      valid_sign_in(user)
    end
    describe 'followed by sign out' do
      before { click_link 'Log out' }
      it { should have_link('Log in') }
    end
  end
end
