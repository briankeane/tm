module TM
  class EditTransaction < UseCase
    def run(attrs)
      case
      when TM::Database.db.get_transaction(attrs[:transaction_id]) == nil
        return failure :transaction_not_found
      else
        transaction = TM::Database.db.edit_transaction(attrs)
        return success :transaction => transaction
      end
    end
  end
end
