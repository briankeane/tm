module TM
  class EditEmployee < UseCase
    def run(attrs)
      if TM::Database.db.get_employee(attrs[:employee_id]) == nil
        return failure(:employee_not_found)
      else employee = TM::Database.db.edit_employee(attrs)
        return success :employee => employee
      end
    end
  end
end
