class CreateRecurringExpenses < ActiveRecord::Migration[8.1]
  def change
    create_table :recurring_expenses do |t|
      t.string :name
      t.decimal :amount, precision: 10, scale: 2
      t.integer :interval_days
      t.date :billing_date
      t.boolean :fixed_date

      t.timestamps
    end
  end
end
