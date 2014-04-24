require 'spec_helper'

module TM

  describe 'CreateArtist' do
    it "Calls bullshit if the name is left blank" do
      result = TM::CreateArtist.run({ :name => '', :manager_share => 0.15,
                                  :booking_share => 0.10 })
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:name_input_blank)
    end

    it "Creates an Artist if everything is correct" do
      result = TM::CreateArtist.run({ :name => 'Bob', :manager_share => 0.15,
                                  :booking_share => 0.10 })
      expect(result.success?).to eq(true)
      expect(result.artist.id).to_not be_nil
    end
  end
end
