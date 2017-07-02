require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  subject { page }

  describe 'GET /users/sign_up' do
    before { visit new_user_registration_path}

    describe 'with valid content' do
      it { should have_title 'Sign up'}
      it { should have_content 'Sign up'}
    end

    let(:submit) { 'Sign up' }

    describe 'with invalid information' do
      it 'should not create a user' do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe 'after submission' do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('problems') }
      end
    end

    describe 'with valid information' do
      before do
        fill_in 'First name',   with: 'Ivan'
        fill_in 'Last name',    with: 'Ivanov'
        fill_in 'Email',        with: 'user@example.com'
        fill_in 'Password',     with: 'foobar'
        fill_in 'Confirmation', with: 'foobar'
      end

      it 'should create a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe 'after saving the user' do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_title(user.first_name) }
        it { should have_css('flash-message') }
        it { should have_link('Profile',     href: user_path(user)) }
        it { should have_link('Log out',    href: destroy_user_session_path) }
      end
    end
  end

  describe 'GET /users/:id' do
    let(:user) { FactoryGirl.create(:user) }

    before { visit user_path(user)}

    it { should have_content(user.first_name) }
    it { should have_title(user.first_name)}
  end

end
