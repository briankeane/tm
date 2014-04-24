require 'spec_helper'

module TM

  describe "CreateTour" do
    it "calls bullshit if start_date is empty" do
      result = TM::CreateTour.run({ start_date: "", end_date: Date.new(2014, 4,6), artist_id: 9999 })
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:start_date_invalid)
    end
    it "calls bullshit if the artist is not found" do
      result = TM::CreateTour.run({ start_date: Date.new(2014, 4, 6), end_date: Date.new(2014, 4,6), artist_id: 9999 })
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:artist_not_found)
    end

    it "creates a tour" do
      artist = TM::Database.db.create_artist({ :name => 'Bob', :manager_share => 0.15,
                                               :booking_share => 0.10 })
      result = TM::CreateTour.run({ start_date: Date.new(2014, 4, 8), end_date: Date.new(2014, 4,6), artist_id: artist.id })
      expect(result.success?).to eq(true)
      expect(result.tour.id).to_not be_nil
    end
  end
end
