Rails.application.routes.draw do
  resources :equips
  resources :statuses
  get "profile/graphs", :to => "profiles#graph", :as => "profile_graphs"
  resources :profiles
  resources :names
  resources :proper_names
  resources :uploaded_checks
  get "privacy", :to => "top_page#privacy", :as => "privacy"
  root 'top_page#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
