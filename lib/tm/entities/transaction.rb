module TM
  class Transaction

    attr_reader :amount, :source, :description, :date, :id, :tour_id

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

