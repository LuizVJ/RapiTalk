Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :contacts
      resources :addresses
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
