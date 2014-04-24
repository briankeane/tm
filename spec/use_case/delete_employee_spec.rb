require 'spec_helper'

describe 'Delete Employee' do
  it "calls bullshit if the employee can't be found" do
    result = TM::DeleteEmployee.run(99999)
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:employee_not_found)
  end

  it "deletes an employee" do
    employee = TM::Database.db.create_employee({ first_name: "Bob", last_name: "Dole",
                                        ssn: "249-35-2213", artist_id: 1 })
    result = TM::DeleteEmployee.run(employee.id)
    expect(result.success?).to eq(true)
  end

end
