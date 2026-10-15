# Expense Prediction App

A Rails app that tracks recurring and one-time expenses and predicts what you'll owe in any given month or year — built as a hands-on learning project to go deep on Rails internals (Stimulus, strong params, respond_to, ActiveRecord query logic) rather than follow a tutorial.

## What it does

- Track recurring expenses (rent, Wi-Fi, EMIs, gas cylinder) with flexible billing cycles — fixed calendar dates (e.g. "27th every month") or rough day-interval estimates (e.g. "roughly every 60 days")
- Track one-time expenses alongside recurring ones
- Support expenses with a defined end date (e.g. an EMI that stops after a fixed period)
- View monthly and yearly expense projections, calculated by simulating each expense's recurrence pattern forward in time
- Mark an expense "paid" with one click, which correctly advances its next billing date depending on whether it's calendar-fixed or interval-based

## Why I built this

I started this project to learn Rails properly — not by following a tutorial, but by building something I'd actually use, and treating every bug as a lesson instead of just fixing and moving on. It originally started as an inventory management demo, then pivoted to an expense tracker once I realized I wanted something with real daily utility.

## Tech stack

- Ruby on Rails 8.1
- SQLite
- Hotwire (Turbo + Stimulus) — no separate frontend framework
- Vanilla CSS with custom properties (no framework)

## Notable things I debugged and learned along the way

- HTML table nesting rules silently breaking a Stimulus controller's scope
- Why `fetch()` following a Rails redirect produces a 404, and how `respond_to` fixes it
- CSRF tokens and the `Content-Type` vs `Accept` header distinction
- A silent `nil.to_i → 0` bug caused by a params key mismatch
- Strong params and mass assignment protection
- Calendar-aware date math (`+1.month`) vs. fixed day-interval math, and why the difference matters for billing dates

Full write-up of these (and more) is on the app's own [`/about`](#) page.

## Setup

\`\`\`bash
bundle install
bin/rails db:setup
bin/rails server
\`\`\`

Visit `http://localhost:3000`.