class RecurringExpense < ApplicationRecord
  def occurrences_between(range_start, range_end)
    dates = []
    current_date = billing_date

    while current_date <= range_end
      dates << current_date if current_date >= range_start
      current_date = fixed_date ? current_date + 1.month : current_date + interval_days.days
    end

    dates
  end
end