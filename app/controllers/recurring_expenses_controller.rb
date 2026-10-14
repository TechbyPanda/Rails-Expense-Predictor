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

  def edit
    @recurring_expense = RecurringExpense.find(params[:id])
  end

  def update
    @recurring_expense = RecurringExpense.find(params[:id])

    if @recurring_expense.update(recurring_expense_params)
      redirect_to recurring_expenses_path, notice: "Expense updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def mark_paid
    expense = RecurringExpense.find(params[:id])
    new_date = expense.fixed_date ? expense.billing_date + 1.month : Date.today + expense.interval_days.days
    expense.update!(billing_date: new_date)
    redirect_to recurring_expenses_path, notice: "#{expense.name} marked paid, next billing: #{new_date}"
  end

  def destroy
    @recurring_expense = RecurringExpense.find(params[:id])
    @recurring_expense.destroy()
    redirect_to recurring_expenses_path, notice: "#{@recurring_expense.name} deleted."
  end

  private

  def recurring_expense_params
    params.require(:recurring_expense).permit(:name, :amount, :interval_days, :billing_date, :fixed_date)
  end
end