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
        it { should have_selector('div', class: 'flash-message') }
        it { should have_link('Profile',     href: user_path(user)) }
        it { should have_link('Log out',    href: destroy_user_session_path) }
      end
    end
  end

  describe 'GET /users/:id/edit' do
    let(:user) { FactoryGirl.create(:user) }

    describe 'as unautorized user' do
      describe 'visit edit page' do
        before { visit edit_user_registration_path }

        it { should have_title 'Log in' }
      end
    end

    describe 'as wrong authorized user' do
      let(:wrong_user) { FactoryGirl.create(:user, first_name: 'Petya', email: 'wrongemail@example.com')}

      before do
        visit new_user_session_path
        valid_sign_in(wrong_user)
        visit edit_user_registration_path(user)
      end

      describe 'view page' do
        it { should have_content wrong_user.first_name}
      end
    end

    describe 'as authorized user' do
      before do
        visit new_user_session_path
        valid_sign_in(user)
        visit edit_user_registration_path(user)
      end

      describe 'view page' do
        it { should have_content("Edit #{user.first_name} #{user.last_name}'s profile") }
        it { should have_title('Edit profile') }
        it { should have_link('Change gravatar', href: 'http://gravatar.com/emails') }
      end

      describe 'with invalid information' do
        before { click_button 'Update' }

        it { should have_content('problems') }
      end

      describe 'with valid information' do
        let(:new_first_name)  { 'Petya' }
        let(:new_last_name) { 'Petrov' }
        let(:new_email) { 'new@example.com' }

        before do
          fill_in 'First name',             with: new_first_name
          fill_in 'Last name', with: new_last_name
          fill_in 'Email',            with: new_email
          fill_in 'Current password', with: user.password
          click_button 'Update'
        end

        it { should have_title(new_first_name) }
        it { should have_selector('div', class: 'flash-message') }
        it { should have_link('Log out',    href: destroy_user_session_path) }
        specify { expect(user.reload.first_name).to  eq new_first_name }
        specify { expect(user.reload.last_name).to  eq new_last_name }
        specify { expect(user.reload.email).to eq new_email }
      end

    end
  end

  describe 'GET /users/:id' do
    let(:user) { FactoryGirl.create(:user) }
    let(:wrong_user) { FactoryGirl.create(:user, first_name: 'Petya', email: 'wrongemail@example.com')}

    before do
      visit new_user_session_path
      valid_sign_in(user)
    end

    describe 'visit profile page' do
      before { visit user_path(user) }

      it { should have_content("#{user.first_name} #{user.last_name}") }
      it { should have_title("#{user.first_name}")}
    end

    describe 'visit other user profile' do
      before { visit user_path(wrong_user) }

      it { should have_content('Home page') }
      it { should have_title('Home')}
    end


  end

  describe 'GET /users' do
    # наличие пагинации
    let(:user) { FactoryGirl.create(:user) }

    before do
      FactoryGirl.create(:user, first_name: 'Bob', email: 'bob@example.com')
      FactoryGirl.create(:user, first_name: 'Ben', email: 'ben@example.com')
    end

    describe 'visit as unauthorized user' do
      before { visit users_path }

      it { should have_title 'Log in' }
    end

    describe 'visit as authorized user' do
      before do
        visit new_user_session_path
        valid_sign_in(user)
        visit users_path
      end

      it { should have_title('All users') }
      it { should have_content('All users') }
      it 'should list each user' do
        User.all.each do |user|
          expect(page).to have_link("#{user.first_name} #{user.last_name}")
        end
      end

      describe 'pagination' do
        before(:all) { 30.times { FactoryGirl.create(:user) } }
        after(:all)  { User.delete_all }

        it { should have_selector('nav.pagination') }

        it 'should list each user' do
          users = User.page(1).per(30)
          users.each do |user|
            expect(page).to have_link("#{user.first_name} #{user.last_name}")
          end
        end

        let(:next_page_user) { User.page(2).per(30).first }

        it { should_not have_link("#{next_page_user.first_name} #{next_page_user.last_name}") }
      end
    end
  end
end
