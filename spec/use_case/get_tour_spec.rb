require 'spec_helper'

describe 'GetTour' do
  it "calls bullshit if the tour doesn't exist" do
    result = TM::GetTour.run(123)
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:tour_not_found)
  end

  it "gets a tour" do
    artist = TM::Database.db.create_artist ({ :name => 'Johnny', :manager_share => 0.15, :booking_share => 0.10 })
    tour = TM::Database.db.create_tour({ start_date: Date.new(2014, 4, 15), end_date: Date.new(2014, 4,17), artist_id: artist.id })
    result = TM::GetTour.run(tour.id)
    expect(result.success?).to eq(true)
    expect(result.tour.id).to eq(tour.id)
  end
end
