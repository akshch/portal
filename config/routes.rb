Rails.application.routes.draw do
  devise_for :users, :controllers => {session: "session", registration: "registration",
                                      omniauth_callbacks: "omniauth_callbacks", confirmations: "confirmations"}
  as :user do
    #   get 'login' => 'session#new', :as => "login"
    #   get 'signup' => 'registrations#new', :as => "signup"
    get "signout" => "devise/sessions#destroy", :as => "signout"
  end
  #root to: 'questions#index'
  resources :questions
  resources :answers
  resources :users

  get "approved", to: "answers#approved"
  get "pending", to: "answers#pending"
  get "rejected", to: "answers#rejected"

  get "search", to: "questions#search"
  get "accepted", to: "questions#accepted"
  get "question/pending", to: "questions#question_pending"
  get "question/rejected", to: "questions#question_rejected"
  post "questions/today"

  get "userr", to: "users#user"
  get "admin", to: "users#admin"
  get "moderator", to: "users#moderator"

  get "category", to: "webpages#category"
  get "profile", to: "webpages#profile"
  root to: "webpages#home"
end
