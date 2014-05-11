require 'spec_helper'

describe User do
  it 'has a valid factory' do
    build(:user).should be_valid
  end

  it 'requires an email' do
    user = build(:user, email: nil)
    user.should_not be_valid
    user.errors.should have_key(:email)
  end
end
