class RecurringExpensesController < ApplicationController
  def index
    @recurring_expenses = RecurringExpense.all
  end

  def new
    @recurring_expense = RecurringExpense.new
  end

  def create
    @recurring_expense = RecurringExpense.new(recurring_expense_params)

    if @recurring_expense.save
      redirect_to recurring_expenses_path, notice: "Expense added!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def recurring_expense_params
    params.require(:recurring_expense).permit(:name, :amount, :interval_days, :billing_date, :fixed_date)
  end
end