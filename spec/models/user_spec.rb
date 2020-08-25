require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "given no password name returns 'Name can't be blank'"do
      user = User.new(
        :firstName => "That",
        :lastName => "Guy",
        :email => "that@guy.com",
        :password => "pikachu",
        :password_confirmation => "pikachu"
      )
      user.save
      expect(user.errors.full_messages[0]).to be_nil
    end

    it "given password does not match password confirmation returns 'Password confirmation doesn't match Password'"do
      user = User.new(
        :firstName => "That",
        :lastName => "Guy",
        :email => "that@guy.com",
        :password => "pikachu",
        :password_confirmation => "pikach"
      )
      user.save
      expect(user.errors.full_messages[0]).to eql("Password confirmation doesn't match Password")
    end

    it "given password does not match password confirmation returns 'Password can't be blank'"do
      user = User.new(
        :firstName => "That",
        :lastName => "Guy",
        :email => "that@guy.com",
        :password_confirmation => "pikach"
      )
      user.save
      expect(user.errors.full_messages[0]).to eql("Password can't be blank")
    end

    it 'password too short should give an error' do
      user = User.new(
        :firstName => "That",
        :lastName => "Guy",
        :email => "that@guy.com",
        :password => "pu",
        :password_confirmation => "pu"
      )
      user.save
      expect(user.errors.full_messages[0]).to eq("Password is too short, must be at least 3 characters")
    end
    

  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "when using valid credentials" do
      user = User.new(
        :firstName => "That",
        :lastName => "Guy",
        :email => "that@guy.com",
        :password => "1717",
        :password_confirmation => "1717"
      )
      user.save
      expect(User.authenticate_with_credentials("that@guy.com", "1717")).to be_present
    end
    it "when not using a valid email" do
      user = User.new(
        :firstName => "That",
        :lastName => "Guy",
        :email => "that@guy.com",
        :password => "1717",
        :password_confirmation => "1717"
      )
      user.save
      expect(User.authenticate_with_credentials("tha@guy.com", "1717")).to be_nil
    end
    it "when using varied uppercase in email" do
      user = User.new(
        :firstName => "That",
        :lastName => "Guy",
        :email => "that@Guy.com",
        :password => "1717",
        :password_confirmation => "1717"
      )
      user.save
      expect(User.authenticate_with_credentials("THat@guy.com", "1717")).to be_present
    end
    it "when having initial or trailing spaces in email" do
      user = User.new(
        :firstName => "That",
        :lastName => "Guy",
        :email => "that@guy.com",
        :password => "1717",
        :password_confirmation => "1717"
      )
      user.save
      expect(User.authenticate_with_credentials("  that@guy.com", "1717")).to be_present
    end
  end

end

