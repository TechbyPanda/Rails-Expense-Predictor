Rails.application.routes.draw do
  get "recurring_expenses/index"
  resources :recurring_expenses, only: [:index, :new, :create, :edit, :update, :destroy] do
    member do
      patch :mark_paid
    end
  end
  root "recurring_expenses#index"

  # Static pages routes
  get "/about", to: "pages#about", as: "about"
  get "/problems", to: "pages#problems", as: "problems"
  get "/interview_questions", to: "pages#interview_questions", as: "interview_questions"

  get "/expenses/monthly", to: "expense_summaries#monthly", as: "monthly_summary"
  get "/expenses/yearly", to: "expense_summaries#yearly", as: "yearly_summary"
end
