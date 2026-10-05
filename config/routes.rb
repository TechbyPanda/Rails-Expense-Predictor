Rails.application.routes.draw do
  get "recurring_expenses/index"
  resources :recurring_expenses, only: [:index, :new, :create]
  root "recurring_expenses#index"

  # Static pages routes
  get "/about", to: "pages#about", as: "about"
  get "/problems", to: "pages#problems", as: "problems"
  get "/interview_questions", to: "pages#interview_questions", as: "interview_questions"
end
