Rails.application.routes.draw do
  root "pages#home"

  namespace :api do
    namespace :v1 do
      resources :venues
    end
  end
end
