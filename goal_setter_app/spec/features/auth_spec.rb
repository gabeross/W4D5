require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  background :each do 
    visit new_user_path
  end 
    
  scenario 'has a new user page' do 
    save_and_open_page
    expect(page).to have_content('Sign Up')
  end 
    
  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      user = FactoryBot.create(:user)
      visit user_url(user)
      expect(page).to have_content("#{user.username}")
    end 
  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login'

end

feature 'logging out' do
  scenario 'begins with a logged out state'

  scenario 'doesn\'t show username on the homepage after logout'

end