Rails.application.routes.draw do
  resources :obsolescences, only: [:index]
  resources :spells, only: [:index]
  resources :tune_gem_data, only: [:index]
  resources :spell_data, only: [:index]
  resources :items, only: [:index]
  get "equip/graphs", :to => "equips#graphs", :as => "equip_graphs"
  resources :equips, only: [:index]
  resources :statuses, only: [:index]
  get "profile/graphs", :to => "profiles#graphs", :as => "profile_graphs"
  resources :profiles, only: [:index]
  resources :names, only: [:index] do collection do get "json" end end
  resources :proper_names, only: [:index]
  resources :uploaded_checks, only: [:index]
  get "privacy", :to => "top_page#privacy", :as => "privacy"
  root 'top_page#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
