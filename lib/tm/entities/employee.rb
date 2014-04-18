module TM
  class Employee

    attr_reader :id, :first_name, :last_name, :ssn, :artist_id

    def initialize(attrs) #id, first_name, last_name, ssn, artist_id
      @id = attrs[:id]
      @first_name = attrs[:first_name]
      @last_name = attrs[:last_name]
      @ssn = attrs[:ssn]
      @artist_id = attrs[:artist_id]
    end
  end
end
