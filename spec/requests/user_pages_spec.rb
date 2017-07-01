require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  subject { page }

  describe 'GET /users/sing_in' do
    before { visit new_user_session_path}

    it { should have_title 'Log in'}
    it { should have_content 'Log in'}
  end

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
    end
  end

  describe 'GET /users/:id' do
    let(:user) { FactoryGirl.create(:user) }

    before { visit user_path(user)}

    it { should have_content(user.first_name) }
    it { should have_title(user.first_name)}
  end

end
