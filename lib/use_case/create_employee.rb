module TM
  class CreateEmployee < UseCase
    def run(attrs)
      case
      when TM::Database.db.get_artist(attrs[:artist_id]) == nil
        return failure :artist_id_not_found
      when attrs[:first_name].empty?
        return failure :first_name_empty
      when attrs[:last_name].empty?
        return failure :last_name_empty
      else
      employee = TM::Database.db.create_employee(attrs)
      return success :employee => employee
      end
    end
  end
end
