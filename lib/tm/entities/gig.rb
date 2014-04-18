module TM
  class Gig

    attr_reader :venue, :city, :market, :cc_sales, :cash_sales, :tour_id
    attr_reader :deposit, :walk, :tips, :id, :type, :cover, :paid

    def initialize(attrs)
      @venue = attrs[:venue]
      @city = attrs[:city]
      @market = attrs[:market]
      @cc_sales = attrs[:cc_sales]
      @cash_sales = attrs[:cash_sales]
      @deposit = attrs[:deposit]
      @walk = attrs[:walk]
      @tips = attrs[:tips]
      @id = attrs[:id]
      @type = attrs[:type]
      @cover = attrs[:cover]
      @paid = attrs[:paid]
      @tour_id = attrs[:tour_id]
    end

    def total_merch
      @cc_sales + @cash_sales
    end

    def total_income
      total_merch + @walk + @deposit
    end

    def total_towards_deposit
      @walk + @cash_sales
    end

    def merch_per_attendee
      total_merch.to_f/@paid
    end

  end
end
