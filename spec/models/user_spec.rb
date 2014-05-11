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

  it 'deletes all associated gadgets on removing' do
    user = create(:user)
    gadget1 = create(:gadget, user: user)
    gadget2 = create(:gadget, user: user)
    another_user_gadget = create(:gadget)
    Gadget.count.should eq(3)

    user.destroy
    user.should_not be_persisted
    Gadget.all.should eq([another_user_gadget])
  end
end
