module TM
  class CreateUser < UseCase
    def run(attrs)
      user = TM::Database.db.get_user_by_username(attrs[:username])
      case
      when user != nil
        return failure(:username_taken)
      else
        user = TM::Database.db.(user.id)
        return success :user => user
      end
    end
  end
end
