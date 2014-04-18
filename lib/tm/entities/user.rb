module TM
  class User

    attr_reader :username, :password, :id

    def initialize(attrs)  # username(string), password(string), id(integer)
      @username = attrs[:username]
      @password = attrs[:password]
      @id = attrs[:id]
    end
  end



end
