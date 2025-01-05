class ExceptMonthlyTransactionService
  def initialize(transaction_ids)
    @transaction_params = Transaction.where(id: transaction_ids)
  end

  def except_monthly_transations
    @transaction_params.each do |transaction|
      date = transaction.date.to_date
      year_month = Date.new(date.year, date.month, 1)
      matched_data = CalculatedMonthlyTransaction.where("EXTRACT(YEAR FROM month) = ? AND EXTRACT(MONTH FROM month) = ?", date.year, date.month).where(transaction_type: transaction.transaction_type).first
      category_id = transaction.category_id
      amount = transaction.amount.to_f

      update_existing_transaction(matched_data, category_id, amount)
    end
  end

  private

  def update_existing_transaction(matched_data, category_id, amount)
    total = matched_data.total.to_f - amount

    total_by_category = matched_data.total_by_category
    percentage_by_category = matched_data.percentage_by_category
    except_by_category(category_id, amount, total, total_by_category, percentage_by_category)

    if total == 0
      matched_data.destroy
    else
      matched_data.update(
        total: total,
        total_by_category: total_by_category,
        percentage_by_category: percentage_by_category
      )
    end
  end

  def except_by_category(category_id, amount, total, total_by_category, percentage_by_category)
    total_by_category[category_id.to_s] -= amount
    total_by_category.each do |key, value|
      if value != 0
        percentage_by_category[key] = ((value / total) * 100.0).round(2)
      else
        total_by_category.delete(key)
        percentage_by_category.delete(key)
      end
    end
  end
end
