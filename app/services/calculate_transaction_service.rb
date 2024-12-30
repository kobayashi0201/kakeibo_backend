class CalculateTransactionService
  def initialize(transaction_params)
    @transaction_params = transaction_params
  end

  def calculate_monthly_transations
    date = @transaction_params[:date].to_date
    year_month = Date.new(date.year, date.month, 1)
    matched_data_by_date = CalculatedMonthlyTransaction.where("EXTRACT(YEAR FROM month) = ? AND EXTRACT(MONTH FROM month) = ?", date.year, date.month).first
    category_id = @transaction_params[:category_id]
    amount = @transaction_params[:amount].to_f

    if matched_data_by_date
      update_existing_transaction(matched_data_by_date, category_id, amount)
    else
      create_new_transaction(year_month, category_id, amount)
    end
  end

  private

  def update_existing_transaction(matched_data_by_date, category_id, amount)
    total = matched_data_by_date.total.to_f + amount

    total_by_category = matched_data_by_date.total_by_category
    if total_by_category[category_id.to_s]
      total_by_category[category_id.to_s] += amount
    else
      total_by_category[category_id.to_s] = amount
    end

    percentage_by_category = matched_data_by_date.percentage_by_category
    percentage_by_category[category_id.to_s] = (total_by_category[category_id.to_s] / total) * 100.0

    matched_data_by_date.update(
      total: total,
      total_by_category: total_by_category,
      percentage_by_category: percentage_by_category
    )
  end

  def create_new_transaction(year_month, category_id, amount)
    CalculatedMonthlyTransaction.create(
      user_id: @transaction_params[:user_id],
      month: year_month,
      total: amount,
      total_by_category: { category_id.to_s => amount },
      percentage_by_category: { category_id.to_s => 100.0 }
    )
  end
end
