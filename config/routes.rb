Rails.application.routes.draw do
  root "members#index"

  # Could use resources to create all CRUD routes for members, but we do not need edit/update or delete
  get '/members', to: "members#index"
  get '/members/:id', to: "members#show", as: 'member'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
