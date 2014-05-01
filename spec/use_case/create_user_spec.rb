require 'spec_helper'

module TM

  describe "CreateUser" do
    it "calls bullshit if username is taken" do
      user = TM::Database.db.create_user({ username: "Bob", password: "password" })
      result = TM::CreateUser.run({ username: "Bob", password: "another" })
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:username_taken)
    end

    it "creates a user" do
      result = TM::CreateUser.run({ username: "Alice", password: "password2" })
      expect(result.success?).to eq(true)
      expect(result.user.id).to_not be_nil
    end
  end
end
