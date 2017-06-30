require 'rails_helper'

RSpec.describe User do
  before { @user = User.new(first_name: 'Ivan', last_name: 'Ivanov',
                            email: 'user@example.com', password: '123456',
                            password_confirmation: '123456') }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  describe 'when first_name is not present' do
    before { @user.first_name = ' ' }
    it { should_not be_valid }
  end
  describe 'when first_name is too long' do
    before { @user.first_name = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'when last_name is not present' do
    before { @user.last_name = ' ' }
    it { should_not be_valid }
  end
  describe 'when last_name is too long' do
    before { @user.last_name = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'when email is not present' do
    before { @user.email = ' ' }
    it { should_not be_valid }
  end
  describe 'when email format is invalid' do
    it 'should be invalid' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end
  describe 'when email format is valid' do
    it 'should be valid' do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end
  describe 'when email address is already taken' do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe 'when password is not present' do
    before { @user.password = @user.password_confirmation = ' ' }
    it { should_not be_valid }
  end
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = 'a' * 5 }
    it { should be_invalid }
  end
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = 'mismatch' }
    it { should_not be_valid }
  end
end
