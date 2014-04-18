module TM
  class Tour

    attr_reader :start_date, :end_date, :id

    def initialize(attrs)  #start_date, @end_date, #id
      @id = attrs[:id]
      @start_date = attrs[:start_date]
      @end_date = attrs[:end_date]
    end

  end
end
