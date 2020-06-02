require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create a user with all fields filled correctly' do
    @user = User.new(first_name: "First", last_name: "Last", email: "me@me.ca", password: "123456", password_confirmation: "123456")
     @user.save
     expect(@user).to be_persisted
   end
   it 'should not create if passwords do not match' do
    @user = User.new(first_name: "First", last_name: "Last", email: "me@me.ca", password: "123456", password_confirmation: "123486")
     @user.save
     expect(@user).not_to be_persisted
   end
   it 'should not create if password is not provided' do
    @user = User.new(first_name: "First", last_name: "Last", email: "me@me.ca", password: nil, password_confirmation: "123456")
     @user.save
     expect(@user).not_to be_persisted
   end
   it 'should not create if first name is not provided' do
    @user = User.new(first_name: nil, last_name: "Last", email: "me@me.ca", password: "123456", password_confirmation: "123456")
     @user.save
     expect(@user).not_to be_persisted
   end
   it 'should not create if last name is not provided' do
    @user = User.new(first_name: "First", last_name: nil, email: "me@me.ca", password: "123456", password_confirmation: "123456")
     @user.save
     expect(@user).not_to be_persisted
   end
   it 'should not create if email is not provided' do
    @user = User.new(first_name: "First", last_name: "Name", email: nil, password: "123456", password_confirmation: "123456")
     @user.save
     expect(@user).not_to be_persisted
   end
   it 'should not create if password is too short' do
    @user = User.new(first_name: "First", last_name: "Name", email: nil, password: "1234", password_confirmation: "1234")
     @user.save
     expect(@user).not_to be_persisted
   end
   it 'should not create if email already in use' do
    @user1 = User.new(first_name: "First", last_name: "Last", email: "me@me.ca", password: "123456", password_confirmation: "123456")
     @user1.save
     @user2 = User.new(first_name: "First", last_name: "Last", email: "ME@me.ca", password: "123456", password_confirmation: "123456")
    @user2.save
     expect(@user2).not_to be_persisted
   end
  end
  describe '.authenticate_with_credentials' do
  it 'should log in with all fields correct' do
    @user = User.new(first_name: "First", last_name: "Name", email: "me@meme.ca", password: "123456", password_confirmation: "123456")
    @user.save
    expect(User.authenticate_with_credentials("me@meme.ca", "123456")).to be_present
  end
  it 'should not log in with incorrect password' do
    @user = User.new(first_name: "First", last_name: "Name", email: "me@meme.ca", password: "123456", password_confirmation: "123456")
    @user.save
    expect(User.authenticate_with_credentials("me@meme.ca", "123455")).not_to be_present
  end
  it 'should log in with correct email with spaces and/or variations in case' do
    @user = User.new(first_name: "First", last_name: "Name", email: "me@meme.ca", password: "123456", password_confirmation: "123456")
    @user.save
    expect(User.authenticate_with_credentials(" me@meME.ca", "123456")).to be_present
  end
end

end

