Rails.application.routes.draw do
  resources :transfers, except: %i[update destroy]
  resources :accounts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
