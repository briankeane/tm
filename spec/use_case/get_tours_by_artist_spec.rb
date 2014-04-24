require 'spec_helper'

describe "GetToursByArtist" do
  it "calls bullshit if the artist can't be found" do
    result = TM::GetToursByArtist.run(999)
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:artist_not_found)
  end

  it "gets an array of tours by artist" do
    artist = TM::Database.db.create_artist ({ :name => 'Johnny', :manager_share => 0.15, :booking_share => 0.10 })
    tour = TM::Database.db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17), artist_id: artist.id })
    tour2 = TM::Database.db.create_tour({ start_date: Date.new(2014, 5, 15), end_date: Date.new(2014, 5,17), artist_id: artist.id })
    tour3 = TM::Database.db.create_tour({ start_date: Date.new(2014, 6, 15), end_date: Date.new(2014, 6,17), artist_id: artist.id })
    tour4 = TM::Database.db.create_tour({ start_date: Date.new(2014, 6, 16), end_date: Date.new(2014, 6,18), artist_id: (artist.id + 5) })
    result = TM::GetToursByArtist.run(artist.id)
    expect(result.success?).to eq(true)
    expect(result[:tours].size).to eq(3)
    expect(result[:tours][0].start_date).to eq(Date.new(2014, 4, 15))
    expect(result[:tours][2].start_date).to eq(Date.new(2014, 6, 15))
  end
end
