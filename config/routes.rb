Rails.application.routes.draw do
  root "members#index"

  get '/members', to: "members#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
