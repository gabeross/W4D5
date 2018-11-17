require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  subject(:user) { FactoryBot.create(:user) }
  
  
  describe "GET #new" do
    it "renders he new user's template" do
      get :new
      expect(response).to render_template(:new)
    end
  end
  
  describe 'POST #create' do
    context 'with valid params' do
      it 'logs in the user' do
        post :create, params: { user: {username: user.username, password: 'password'} }
        # user = User.find_by(username: 'joe')
        p user
        expect(session[:session_token]).to eq(user.session_token)
      end
      
      it 'redirect user to their show page' do
        post :create, params: { user: {username: 'joe', password: "password"} }
        # user = User.find_by(username: 'joe')
        p user
        expect(response).to redirect_to(user_url(user))
      end
    end
    
    context 'with invalid params' do
      it 'returns an error' do
        post :create, params: { user: {username: 'joe', password: ""} }
        # user = User.find_by(username: 'joe')
        p user
        expect(flash[:errors]).to be_present
      end
      
      it 'stays on the new user page' do
        post :create, params: { user: {username: 'joe', password: ""} }
        # user = User.find_by(username: 'joe')
        p user
        expect(response).to render_template('new')
      end
    end
  end
  
  describe 'GET #index' do
    it 'redirects user to index page' do 
      get :index
      p user
      expect(response).to render_template('index')
    end 
  end 
  
  describe 'GET #show' do
    it 'redirect user to requested show page' do
      user = FactoryBot.create(:user)
      get :show, params: { id: user.id }
      expect(response).to redirect_to(user_url(user))
    end
  end 
end
