require "spec_helper"
# Feature: Sign in
#   As a user
#   I want to sign in
#   So I can visit protected areas of the site
feature 'Sign in', :devise do

  # Scenario: User cannot sign in if not registered
  #   Given I do not exist as a user
  #   When I sign in with valid credentials
  #   Then I see an invalid credentials message
  scenario 'user cannot sign in if not registered' do
    visit new_user_session_path
    fill_in 'Email', with: 'user@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    # signin('test@example.com', 'please123')
    expect(page).to have_content I18n.t('devise.failure.not_found_in_database', authentication_keys: 'email')
  end

  # Scenario: User can sign in with valid credentials
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with valid credentials
  #   Then I see a success message
  scenario 'user can sign in with valid credentials' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    # signin(user.email, user.password)
    expect(page).to have_content I18n.t('devise.sessions.signed_in')
  end

  # Scenario: User cannot sign in with wrong email
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with a wrong email
  #   Then I see an invalid email message
  scenario 'user cannot sign in with wrong email' do
    user = FactoryGirl.create(:user)
        visit new_user_session_path
      fill_in 'Email', with: 'ldjsf@lsjf.com'
      fill_in 'Password', with: user.password
      click_button 'Log in'
    # signin('invalid@email.com', user.password)
    expect(page).to have_content I18n.t('devise.failure.not_found_in_database', authentication_keys: 'email')
  end

  # Scenario: User cannot sign in with wrong password
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with a wrong password
  #   Then I see an invalid password message
  scenario 'user cannot sign in with wrong password' do
    user = FactoryGirl.create(:user)
        visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'sdkjf'
      click_button 'Log in'
    # signin(user.email, 'invalidpass')
    expect(page).to have_content I18n.t('devise.failure.invalid', authentication_keys: 'email')
  end

end