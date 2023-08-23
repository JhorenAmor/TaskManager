Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      root "tasks#index"
      resources :tasks, only: %i[index show create update destroy] do
        member do
          patch "move"
        end
      end
    end
  end
end
