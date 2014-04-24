require 'spec_helper'

describe 'EditArtist' do
  it "calls bullshit if artist not found" do
    result = TM::EditArtist.run({ artist_id: 99999, name: 'Bob' })
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:artist_not_found)
  end

  it "changes an artists info" do
    artist = TM::Database.db.create_artist({ name: 'Bob', manager_share: 0.1, booking_share: 0.15 })
    result = TM::EditArtist.run({ artist_id: artist.id, name: 'Sue' })
    expect(result.success?).to eq(true)
    expect(result.artist.id).to eq(artist.id)
    expect(result.artist.name).to eq('Sue')
    result = TM::EditArtist.run({ artist_id: artist.id, manager_share: 0.2, booking_share: 0.3 })
    expect(result.artist.booking_share).to eq(0.3)
    expect(artist.manager_share).to eq(0.2)
  end

end
