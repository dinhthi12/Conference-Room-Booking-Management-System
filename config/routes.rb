Rails.application.routes.draw do
  # Devise routes for omniauth callbacks should be defined outside the locale scope
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: "users/omniauth_callbacks",
                                                               confirmations: "users/confirmations" }

  scope "(:locale)", locale: /en|vi|ja/ do
    root "static_pages#home"

    # Routes cho StaticPagesController
    get "home", to: "static_pages#home"
    get "help", to: "static_pages#help"
    get "action", to: "static_pages#action"
    get "product", to: "static_pages#product"
    get "service", to: "static_pages#service"
    get "new_feed", to: "static_pages#new_feed"
    get "contact", to: "static_pages#contact"

    # Devise routes, excluding omniauth callbacks
    devise_for :users, skip: :omniauth_callbacks, controllers: {
                         sessions: "users/sessions",
                         registrations: "users/registrations",
                         passwords: "users/passwords",
                         confirmations: "users/confirmations",
                         unlocks: "users/unlocks",
                       }

    get "dashboard", to: "dashboard#index"
  end

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
