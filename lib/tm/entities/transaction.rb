module TM
  class Transaction

    attr_accessor :amount, :source, :description, :date, :tour_id
    attr_reader :id

    def initialize(attrs)  #amount, #source, #description, #date, #id
      @amount = attrs[:amount]
      @source = attrs[:source]
      @description = attrs[:description]
      @date = attrs[:date]
      @id = attrs[:id]
      @tour_id = attrs[:tour_id]
    end
  end
end
