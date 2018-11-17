require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do 
    FactoryBot.create(:user)
  end 
  
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_uniqueness_of(:username) }
  
  context 'session token test' do 
    it 'assigns the session token if not given' do 
      user = FactoryBot.create(:user)
      expect(user.session_token).not_to be_nil
    end 
  end
  
  # it { should have_many(:goals) }
  # it { should have_many(:comments) }
  
  describe "::find_by_credentials" do
    it "finds a user by credentials" do
      user = FactoryBot.create(:user)
      User.find_by_credentials(user.username, user.password)
    end
  end
  
end
