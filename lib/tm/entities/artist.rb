module TM
  class Artist

    attr_reader :name, :id, :manager_share, :booking_share

    def initialize(attrs)  # name(string), manager_share(%), artist_share(%), id(int)
      @name = attrs[:name]
      @id = attrs[:id]
      @manager_share = attrs[:manager_share]
      @booking_share = attrs[:booking_share]
    end
  end



end
