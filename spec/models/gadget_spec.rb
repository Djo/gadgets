require 'spec_helper'

describe Gadget do
  it 'has a valid factory' do
    build(:gadget).should be_valid
  end

  it 'requires an email' do
    gadget = build(:gadget, name: nil)
    gadget.should_not be_valid
    gadget.errors.should have_key(:name)
  end

  it 'requires an user' do
    gadget = build(:gadget, user: nil)
    gadget.should_not be_valid
    gadget.errors.should have_key(:user)
  end
end
