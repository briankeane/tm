module TM
  class Tour

    attr_reader :id
    attr_accessor :start_date, :end_date, :id, :artist_id

    def initialize(attrs)  #start_date, @end_date, #id
      @id = attrs[:id]
      @start_date = attrs[:start_date]
      @end_date = attrs[:end_date]
      @artist_id = attrs[:artist_id]
    end

    def cc_total
      transactions = TM::Database.db.get_transactions_by_tour(@id)
      sum = 0.0
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

    def booking_bill
      gigs = TM::Database.db.get_gigs_by_tour(@id)
      total_deposits = 0.0
      gigs.each do |g|
        total_deposits += g.deposit
      end
      booking_share - total_deposits
    end

    def total_gig_pay_towards_deposit
      gigs = TM::Database.db.get_gigs_by_tour(@id)
      total = 0
      gigs.each do |gig|
        total += gig.walk
        total += gig.cash_sales
      end
      total
    end

    def cash_in_out
      transactions = TM::Database.db.get_transactions_by_tour(@id)
      sum = 0
      transactions.each do |t|
        if t.source == "cash"
          sum+= t.amount
        end
      end
      sum
    end

    def deposit
      total_gig_pay_towards_deposit + cash_in_out
    end

    def gross
      gigs = TM::Database.db.get_gigs_by_tour(@id)
      total = 0
      gigs.each do |gig|
        total += gig.total_income
      end
      total
    end

    def expenses
      transactions = TM::Database.db.get_transactions_by_tour(@id)
      total = 0
      transactions.each do |t|
        if t.amount < 0
          total += t.amount
        end
      end
      total
    end

    def credits
      transactions = TM::Database.db.get_transactions_by_tour(@id)
      total = 0
      transactions.each do |t|
        if t.amount > 0
          total += t.amount
        end
      end
      total
    end

    def manager_share  # based on net
      (self.gross + self.expenses + self.credits) * TM::Database.db.get_artist(@artist_id).manager_share
    end

    def net
      self.gross + self.expenses + self.credits - self.booking_share - TM::Database.db.get_artist(@artist_id).manager_share
    end

  end
end
