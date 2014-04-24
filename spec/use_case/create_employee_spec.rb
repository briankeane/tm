require 'spec_helper'

module TM
  describe 'CreateEmployee'  do
    it "calls bullshit if no user found" do
      result = TM::CreateEmployee.run({ first_name: "Bob",
                                        last_name: "Dole",
                                        ssn: "249-35-0333",
                                        artist_id: 99999999})
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:artist_id_not_found)
    end

    it "calls bullshit if no :first_name" do
      artist = TM::Database.db.create_artist ({ :name => 'Johnny', :manager_share => 0.15, :booking_share => 0.10 })
      result = TM::CreateEmployee.run({ first_name: "",
                                        last_name: "Dole",
                                        ssn: "249-35-0333",
                                        artist_id: artist.id })
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:first_name_empty)
    end

    it "calls bullshit if no :last_name" do
      artist = TM::Database.db.create_artist ({ :name => 'Johnny', :manager_share => 0.15, :booking_share => 0.10 })
      result = TM::CreateEmployee.run({ first_name: "Bob",
                                        last_name: "",
                                        ssn: "249-35-0333",
                                        artist_id: artist.id })
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:last_name_empty)
    end

    it "creates an employee" do
      artist = TM::Database.db.create_artist ({ :name => 'Johnny', :manager_share => 0.15, :booking_share => 0.10 })
      result = TM::CreateEmployee.run({ first_name: "Bob",
                                        last_name: "Dole",
                                        ssn: "249-35-0333",
                                        artist_id: artist.id })
      expect(result.success?).to eq(true)
      expect(result.employee.id).to_not be_nil
    end
  end
end

