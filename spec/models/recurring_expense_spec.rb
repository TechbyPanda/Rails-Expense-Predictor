require "rails_helper"

RSpec.describe RecurringExpense, "#occurrences_between" do
  def build_expense(attrs = {})
    RecurringExpense.new({
      name: "Test",
      amount: 100,
      interval_days: 30,
      billing_date: Date.new(2026, 10, 27),
      fixed_date: true,
      one_time: false,
      end_date: nil
    }.merge(attrs))
  end

  context "when the expense is one-time" do
    it "returns the billing date if it falls inside the range" do
      expense = build_expense(one_time: true, billing_date: Date.new(2026, 11, 10))
      result = expense.occurrences_between(Date.new(2026, 11, 1), Date.new(2026, 11, 30))
      expect(result).to eq([Date.new(2026, 11, 10)])
    end

    it "returns nothing if the billing date is outside the range" do
      expense = build_expense(one_time: true, billing_date: Date.new(2026, 11, 10))
      result = expense.occurrences_between(Date.new(2026, 12, 1), Date.new(2026, 12, 31))
      expect(result).to be_empty
    end
  end

  context "when the expense has a fixed calendar date" do
    it "lands on the same day each month" do
      expense = build_expense
      result = expense.occurrences_between(Date.new(2026, 10, 1), Date.new(2027, 1, 31))
      expect(result).to eq([
        Date.new(2026, 10, 27), Date.new(2026, 11, 27),
        Date.new(2026, 12, 27), Date.new(2027, 1, 27)
      ])
    end
  end

  context "when the expense is interval-based" do
    it "steps forward by interval_days" do
      expense = build_expense(fixed_date: false, interval_days: 60, billing_date: Date.new(2026, 10, 15))
      result = expense.occurrences_between(Date.new(2026, 10, 1), Date.new(2027, 2, 28))
      expect(result).to eq([Date.new(2026, 10, 15), Date.new(2026, 12, 14), Date.new(2027, 2, 12)])
    end
  end

  context "when the expense has an end date" do
    it "stops producing occurrences after the end date" do
      expense = build_expense(end_date: Date.new(2026, 12, 31))
      result = expense.occurrences_between(Date.new(2026, 10, 1), Date.new(2027, 6, 30))
      expect(result.last).to eq(Date.new(2026, 12, 27))
    end

    it "returns nothing for a range entirely after the end date" do
      expense = build_expense(end_date: Date.new(2026, 12, 31))
      result = expense.occurrences_between(Date.new(2028, 1, 1), Date.new(2028, 12, 31))
      expect(result).to be_empty
    end
  end
end