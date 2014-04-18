module TM
  class Employee

    attr_reader :id, :first_name, :last_name, :ssn

    def initialize(attrs) #id, first_name, last_name, ssn
      @id = attrs[:id]
      @first_name = attrs[:first_name]
      @last_name = attrs[:last_name]
      @ssn = attrs[:ssn]
    end
  end
end
