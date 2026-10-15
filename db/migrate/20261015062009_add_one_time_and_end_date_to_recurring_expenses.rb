class AddOneTimeAndEndDateToRecurringExpenses < ActiveRecord::Migration[8.1]
  def change
    add_column :recurring_expenses, :one_time, :boolean, default: false
    add_column :recurring_expenses, :end_date, :date
  end
end
