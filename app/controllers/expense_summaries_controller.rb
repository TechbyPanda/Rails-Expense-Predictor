class ExpenseSummariesController < ApplicationController
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
end