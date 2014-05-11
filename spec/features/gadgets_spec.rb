require 'spec_helper'

feature 'Gadgets' do
  scenario 'Accessible only by a logged in user' do
    visit '/gadgets'
    page.should_not have_content('Your own gadgets.')
    page.should have_content('You need to sign in or sign up before continuing.')
  end

  scenario 'Welcomes the user' do
    log_in
    page.should have_content('Your own gadgets.')
  end

  def log_in
    user = create(:user)
    visit "/"
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    find_field('user_password').native.send_key(:enter)

    user
  end
end
