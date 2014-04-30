require 'spec_helper'

describe 'assign_user_artist_relationship' do

  it "calls bullshit if the artist is not found" do
    user = TM::Database.db.create_user ({ username: "Bob", password: "password" })
    result = TM::AssignUserArtistRelationship.run({ user_id: user.id, artist_id: 999999 })
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:artist_not_found)
  end

  it "calls bullshit if user not found" do
    artist = TM::Database.db.create_artist ({ :name => 'Johnny', :manager_share => 0.15, :booking_share => 0.10 })
    result = TM::AssignUserArtistRelationship.run({ artist_id: artist.id, user_id: 9999 })
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:user_not_found)
  end

  it "establishes a user/artist relationship and gets all artists per user" do
    artist = TM::Database.db.create_artist ({ :name => 'Johnny', :manager_share => 0.15, :booking_share => 0.10 })
    user = TM::Database.db.create_user ({ username: "Bob", password: "password" })
    result = TM::AssignUserArtistRelationship.run({ user_id: user.id, artist_id: artist.id })
    expect(result.success?).to eq(true)

    expect(TM::Database.db.get_artists_by_user(user.id).size).to eq(1)
    expect(TM::Database.db.get_artists_by_user(user.id)[0].id).to eq(artist.id)
  end
end
