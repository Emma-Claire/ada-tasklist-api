Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match "/tasks", controller: 'application', action: 'cors_preflight_check', via: [:options]
  match "/tasks/:id", controller: 'application', action: 'cors_preflight_check', via: [:options]
  resources :tasks, except: [:new, :edit]
end
