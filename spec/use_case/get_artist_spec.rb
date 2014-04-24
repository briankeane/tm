require 'spec_helper'

module TM

  describe "GetArtist" do
    it "calls bullshit if artist not found" do
      result = TM::GetArtist.run(99999)
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:artist_not_found)
    end

    it "gets an artist" do
      artist = TM::Database.db.create_artist({ name: "Bob" })
      result = TM::GetArtist.run(artist.id)
      expect(result.success?).to eq(true)
      expect(result.artist.id).to eq(artist.id)
    end
  end
end
