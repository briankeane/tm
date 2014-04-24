module TM
  class DeleteEmployee < UseCase
    def run(employee_id)
      case
      when TM::Database.db.get_employee(employee_id) == nil
        return failure :employee_not_found
      else
        TM::Database.db.delete_employee(employee_id)
        return success
      end
    end
  end
end

