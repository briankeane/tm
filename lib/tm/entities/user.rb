module TM
  class User

    attr_reader :id, :username, :password

    def initialize (attrs) #id, username, password
      @id = attrs[:id]
      @username = attrs[:username]
      @password = attrs[:password]
    end
  end
end

