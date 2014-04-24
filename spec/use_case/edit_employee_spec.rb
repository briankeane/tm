require 'spec_helper'

describe 'EditEmployee' do
  it "calls bullshit if Employee not found" do
    result = TM::EditEmployee.run({ Employee_id: 99999, name: 'Bob' })
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:employee_not_found)
  end

  it "changes an Employees info" do
    employee = TM::Database.db.create_employee({ first_name: 'Bob', last_name: 'Dole', ssn: "555-55-5555" })


    result = TM::EditEmployee.run({ employee_id: employee.id, first_name: 'Sue' })
    expect(result.success?).to eq(true)
    expect(result.employee.id).to eq(employee.id)
    expect(result.employee.first_name).to eq('Sue')
    result = TM::EditEmployee.run({ employee_id: employee.id, last_name: 'Suskin', ssn: "666-66-6666" })
    expect(result.employee.last_name).to eq('Suskin')
    expect(employee.ssn).to eq("666-66-6666")
  end

end
