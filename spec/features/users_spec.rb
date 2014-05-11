feature "Users" do
  scenario "Signing in with correct credentials" do
    create(:user, email: 'user@example.com', password: 'strongpassword')
    visit '/users/sign_in'
    fill_in 'Email', :with => 'user@example.com'
    fill_in 'Password', :with => 'strongpassword'
    find_field('user_password').native.send_key(:enter)
    page.should have_content 'Signed in successfully.'
  end

  scenario "Signing in with incorrect credentials" do
    visit '/users/sign_in'
    fill_in 'Email', :with => 'fake@example.com'
    fill_in 'Password', :with => 'password'
    find_field('user_password').native.send_key(:enter)
    page.should have_content 'Invalid email or password.'
  end

  scenario "Signing up with a new profile" do
    visit '/users/sign_up'
    fill_in 'Email', :with => 'new-user@example.com'
    fill_in 'Password', :with => 'strongpassword'
    fill_in 'Password confirmation', :with => 'strongpassword'
    find_field('user_password').native.send_key(:enter)
    page.should have_content 'Welcome! You have signed up successfully.'
  end
end
