require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations for User model' do
    before(:each) do
      @user = User.new(name: 'Tom', photo: 'image.png', bio: 'Teacher from Mexico', post_counter: 0)
    end

    before { @user.save }

    it 'if there is name' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'PostCounter must be greater than or equal to zero' do
      @user.post_counter = -1
      expect(@user).to_not be_valid
    end

    it 'PostCounter must be greater than or equal to zero' do
      @user.post_counter = 5
      expect(@user).to be_valid
    end
  end
end
