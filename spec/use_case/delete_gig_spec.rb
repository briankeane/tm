require 'spec_helper'

module TM
  describe 'DeleteGig'  do
    it "returns an error if no artist found" do
      result = TM::DeleteGig.run(9999)
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:gig_not_found)
    end

    it "deletes the gig" do
      gig = TM::Database.db.create_gig({ city: "Lubbock" })
      result = TM::DeleteGig.run(gig.id)
      expect(result.success?).to eq(true)
      expect(TM::Database.db.get_gig(gig.id)).to be_nil
    end
  end
end
