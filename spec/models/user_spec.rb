require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.create(:user)} 
  it "email format should be invalid" do
    addresses = %w[user@foo,com user_at_foo.org example.auser@foo. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    addresses.each do |addr|
      user.email = addr
      expect(user).not_to be_valid
    end
  end

  it "with short password" do
    user.password = user.password_confirmation = "a" * 2
    expect(user).not_to be_valid
  end
end
