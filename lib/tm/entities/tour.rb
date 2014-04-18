require 'pry-debugger'
module TM
  class Tour

    attr_reader :start_date, :end_date, :id, :artist_id

    def initialize(attrs)  #start_date, @end_date, #id
      @id = attrs[:id]
      @start_date = attrs[:start_date]
      @end_date = attrs[:end_date]
      @artist_id = attrs[:artist_id]
    end

    def cc_total
      transactions = TM::Database.db.get_transactions_by_tour(@id)
      sum = 0.0
      binding.pry
      transactions.each do |t|
        if t.source == "cc"
          sum += t.amount
        end
      end
      return sum
    end

    def booking_share
      gigs = TM::Database.db.get_gigs_by_tour(@id)
      booking_share = 0.0
      gigs.each do |g|
        booking_share += g.deposit
        booking_share += g.walk
      end
      booking_share * TM::Database.db.get_artist(@artist_id).booking_share
    end






  end
end
