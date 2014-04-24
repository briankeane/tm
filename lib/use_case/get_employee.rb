module TM
  class GetEmployee < UseCase
    def run(employee_id)
      employee = TM::Database.db.get_employee(employee_id)
      case
      when employee == nil
        return failure :employee_not_found
      else
        return success :employee => employee
      end
    end
  end
end
