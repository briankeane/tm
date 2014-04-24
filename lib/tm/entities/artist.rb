module TM
  class Artist

    attr_reader :id
    attr_accessor :name, :manager_share, :booking_share

    def initialize(attrs)  # name(string), manager_share(%), artist_share(%), id(int)
      @name ||= attrs[:name]
      @id = attrs[:id]
      @manager_share = (attrs[:manager_share] ||=  0.0)
      @booking_share = (attrs[:booking_share] ||= 0.0)
    end
  end
end
