require 'spec_helper'

describe 'EditTour' do
  it "calls bullshit if tour not found" do
    result = TM::EditTour.run({ tour_id: 99999, start_date: Date.new(2012, 12, 12) })
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:tour_not_found)
  end

  it "changes an Employees info" do
    artist = TM::Database.db.create_artist({ name: 'Bob' })
    tour = TM::Database.db.create_tour({ artist_id: artist.id, start_date: Date.new(1905, 1, 1),
                                              end_date: Date.new(1906, 1, 1) })
    result = TM::EditTour.run({ tour_id: tour.id, start_date: Date.new(1950, 1, 1) })
    expect(result.success?).to eq(true)
    expect(result.tour.id).to eq(tour.id)
    expect(result.tour.start_date).to eq(Date.new(1950, 1, 1))
    result = TM::EditTour.run({ tour_id: tour.id, end_date: Date.new(1951, 1, 1) })
    expect(tour.end_date).to eq(Date.new(1951, 1, 1))
  end

end
