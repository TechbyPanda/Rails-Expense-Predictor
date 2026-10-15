class RecurringExpense < ApplicationRecord
  def occurrences_between(range_start, range_end)
    return [billing_date].select { |d| d.between?(range_start, range_end) } if one_time

    dates = []
    current_date = billing_date

    while current_date <= range_end
      break if end_date && current_date > end_date
      dates << current_date if current_date >= range_start
      current_date = fixed_date ? current_date + 1.month : current_date + interval_days.days
    end

    dates
  end
end