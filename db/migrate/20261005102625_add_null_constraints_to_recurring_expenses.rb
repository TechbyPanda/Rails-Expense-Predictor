class AddNullConstraintsToRecurringExpenses < ActiveRecord::Migration[8.1]
  def change
    change_column_null :recurring_expenses, :name, false
    change_column_null :recurring_expenses, :amount, false
    change_column_null :recurring_expenses, :interval_days, false
    change_column_null :recurring_expenses, :billing_date, false
    change_column_null :recurring_expenses, :fixed_date, false
  end
end
