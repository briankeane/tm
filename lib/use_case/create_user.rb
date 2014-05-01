module TM
  class CreateUser < UseCase
    def run(attrs)
      user = TM::Database.db.get_user_by_username(attrs[:username])
      case
      when user != nil
        return failure(:username_taken)
      else
        user = TM::Database.db.create_user({ username: attrs[:username], password: attrs[:password] })
        return success :user => user
      end
    end
  end
end
