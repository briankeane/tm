require 'spec_helper'

describe 'SignIn' do
  it "calls bullshit if the username doesn't exist" do
    result = TM::SignIn.run({ username: "123", password: "123" })
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:username_not_found)
  end

  it "calls bullshit if the password is incorrect" do
    user = TM::Database.db.create_user({ username: "Bob", password: "password" })
    result = TM::SignIn.run({ username: "Bob", password: "NOTPASSWORD" })
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:incorrect_password)
  end

  it "signs a user in if all is correct" do
    user = TM::Database.db.create_user({ username: "Bob", password: "password" })
    result = TM::SignIn.run({ username: "Bob", password: "password" })
    #expect(result.success?).to eq(true)

    expect(result.session_id).to_not be_nil
    expect(result.user.id).to eq(user.id)
  end
end
