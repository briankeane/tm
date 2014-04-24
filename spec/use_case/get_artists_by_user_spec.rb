require 'spec_helper'

module TM

  describe "GetArtistsByTour" do
    it "calls bullshit if user not found" do
      result = TM::GetArtistsByUser.run(999)
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:user_not_found)
    end

    it "returns an array of artists associated with a user" do
      user = TM::Database.db.create_user({ username: "Bob", password: "Password" })
      artist1 = TM::Database.db.create_artist({ name: "Brian" })
      artist2 = TM::Database.db.create_artist({ name: "Wade" })
      artist3 = TM::Database.db.create_artist({ name: "Randy" })
      artist4 = TM::Database.db.create_artist({ name: "Stoney" })
      TM::Database.db.assign_user_artist_relationship(user.id, artist1.id)
      TM::Database.db.assign_user_artist_relationship(user.id, artist2.id)
      TM::Database.db.assign_user_artist_relationship(user.id, artist3.id)
      result = TM::GetArtistsByUser.run(user.id)
      expect(result.success?).to eq(true)
      expect(result.artists.size).to eq(3)
      expect(result.artists[0].id).to eq(artist1.id)
    end
  end
end

