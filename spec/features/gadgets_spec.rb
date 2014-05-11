require 'spec_helper'

feature 'Gadgets' do
  scenario 'Accessible only by a logged in user' do
    visit '/gadgets'
    page.should_not have_content('Your own gadgets')
    page.should have_content('You need to sign in or sign up before continuing.')
  end

  scenario 'User sees only his own gadgets' do
    user = log_in
    create(:gadget, name: 'Own gadget', user: user)
    create(:gadget, name: 'Another user gadget')

    visit '/gadgets'
    page.should have_content('Your own gadgets (1)')
    page.should have_content('Own gadget')
    page.should_not have_content('Another user gadget')
  end

  scenario 'Managing own gadgets', js: true do
    log_in
    page.should have_content('Your own gadgets (0)')

    page.should_not have_content('Super gadget')
    click_on 'Create one'
    fill_in 'Name', with: 'Super gadget'
    click_on 'Create Gadget'
    page.should have_content('Super gadget')
    page.should have_content('Your own gadgets (1)')

    page.evaluate_script('window.confirm = function() { return true; }')
    within '#gadgets' do
      click_on 'delete'
    end
    page.should_not have_content('Super gadget')
    page.should have_content('Your own gadgets (0)')
  end

  scenario 'Searching by gadget names' do
    user = log_in
    create(:gadget, name: 'Super gadget', user: user)
    create(:gadget, name: 'Superb gadget', user: user)

    visit '/gadgets'
    page.should have_content('Super gadget')
    page.should have_content('Superb gadget')

    fill_in 'search', with: 'Super'
    click_button 'Search'
    page.should have_content('Super gadget')
    page.should have_content('Superb gadget')

    fill_in 'search', with: 'Superb'
    click_button 'Search'
    page.should_not have_content('Super gadget')
    page.should have_content('Superb gadget')
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
