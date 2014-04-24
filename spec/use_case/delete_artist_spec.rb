require 'spec_helper'

module TM
  describe 'DeleteArtist'  do
    it "returns an error if no artist found" do
      result = TM::DeleteArtist.run(9999)
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:artist_not_found)
    end

    it "deletes the artist" do
      artist = TM::Database.db.create_artist({ :name => 'Bob', :manager_share => 0.15,
                                  :booking_share => 0.10 })
      result = TM::DeleteArtist.run(artist.id)
      expect(result.success?).to eq(true)
      expect(TM::Database.db.get_artist(artist.id)).to be_nil
    end
  end
end
