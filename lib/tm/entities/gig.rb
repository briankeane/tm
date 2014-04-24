module TM
  class Gig

    attr_accessor :venue, :city, :market, :cc_sales, :cash_sales, :tour_id, :date
    attr_accessor :deposit, :walk, :tips, :type, :cover, :paid, :other_bands
    attr_reader :id

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
      @other_bands = attrs[:other_bands]
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
