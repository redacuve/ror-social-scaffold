require 'rails_helper'

RSpec.feature 'Vistor signs in' do
  background do
    User.create(name: 'user', email: 'user@email.com', password: '123456')
  end
  scenario 'with valid email and password' do
    sign_up_with 'user@email.com', '123456'
    expect(page).to have_content('Sign out')
  end
end

def sign_up_with(email, password)
  visit new_user_session_path
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Log in'
end
