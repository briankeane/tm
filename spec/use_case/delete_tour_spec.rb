require 'spec_helper'

module TM

  describe "DeleteTour" do
    it "calls bullshit if the tour doesn't exist" do
      result = TM::DeleteTour.run(9999)
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:tour_not_found)
    end

    it "deletes a tour" do
      tour = TM::Database.db.create_tour({ start_date: Date.new(2014, 4, 6), end_date: Date.new(2014, 4,6), artist_id: 9999 })
      result = TM::DeleteTour.run(tour.id)
      expect(result.success?).to eq(true)
    end
  end
end
