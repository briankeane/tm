require 'bcrypt'

module TM
  class User

    attr_reader :id, :username, :password_digest

    def initialize (attrs) #id, username, password
      @id = attrs[:id]
      @username = attrs[:username]
      @password_digest = BCrypt::Password.create(attrs[:password])
    end

    def password_correct?(password)
      @password_digest == password
    end
  end
end

