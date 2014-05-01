require 'spec_helper'

describe 'SignOut' do
  it "signs out a user" do
    session_id = TM::Database.db.create_session(5)
    TM::SignOut.run({ session_id: session_id })
    expect(TM::Database.db.get_uid_from_sid(session_id)).to be_nil
  end
end
