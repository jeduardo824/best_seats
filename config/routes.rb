Rails.application.routes.draw do
  root "pages#home"

  namespace :api do
    namespace :v1 do
      resources :venues, only: :create do
        get "best_seats", to: "best_seats#find"
      end
    end
  end
end
