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

  def monthly
    @month = params[:month] ? Date.parse(params[:month]) : Date.today
    range_start = @month.beginning_of_month
    range_end = @month.end_of_month

    @rows = RecurringExpense.all.flat_map do |expense|
      expense.occurrences_between(range_start, range_end).map { |date| { expense: expense, date: date } }
    end

    @total = @rows.sum { |row| row[:expense].amount }
  end

  def yearly
    @year = params[:year] ? params[:year].to_i : Date.today.year
    range_start = Date.new(@year, 1, 1)
    range_end = Date.new(@year, 12, 31)

    @by_month = (1..12).map do |m|
      month_start = Date.new(@year, m, 1)
      month_end = month_start.end_of_month
      total = RecurringExpense.all.sum do |expense|
        expense.occurrences_between(month_start, month_end).size * expense.amount
      end
      { month: month_start, total: total }
    end

    @year_total = @by_month.sum { |row| row[:total] }
  end

  private

  def recurring_expense_params
    params.require(:recurring_expense).permit(:name, :amount, :interval_days, :billing_date, :fixed_date, :one_time, :end_date)
  end
end