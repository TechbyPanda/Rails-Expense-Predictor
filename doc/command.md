# Commands

## To kill server and restart it
rm -f tmp/pids/server.pid
bin/rails server

`bin/rails generate model RecurringExpense name:string amount:'decimal{10,2}' interval_days:integer billing_date:date fixed_date:boolean`

`bin/rails generate migration AddNullConstraintsToRecurringExpenses`

`bin/rails generate controller RecurringExpenses index`