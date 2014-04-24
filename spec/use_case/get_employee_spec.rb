require 'spec_helper'

describe 'GetEmployee' do
  it "calls bullshit if the employee doesn't exist" do
    result = TM::GetEmployee.run(123)
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:employee_not_found)
  end

  it "gets an employee" do
    artist = TM::Database.db.create_artist ({ :name => 'Johnny', :manager_share => 0.15, :booking_share => 0.10 })
    employee = TM::Database.db.create_employee({ first_name: "Bob", last_name: "Dole", ssn: "33-333-3333", artist_id: artist.id })
    result = TM::GetEmployee.run(employee.id)
    expect(result.success?).to eq(true)
    expect(result.employee.id).to eq(employee.id)
  end
end
