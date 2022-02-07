Rails.application.routes.draw do
  resources :obsolescences,   only: [:index] do collection do get "json"; get "json_pno"  end end
  resources :spells,          only: [:index] do collection do get "json"; get "json_pno"  end end
  resources :tune_gem_data,   only: [:index] do collection do get "json"; get "json_pno"  end end
  resources :spell_data,      only: [:index] do collection do get "json"; get "json_pno" end end
  resources :items,           only: [:index] do collection do get "json"; get "json_pno"  end end
  get "equip/graphs", :to => "equips#graphs", :as => "equip_graphs"
  resources :equips,          only: [:index] do collection do get "json"; get "json_pno"  end end
  resources :statuses,        only: [:index] do collection do get "json"; get "json_pno"  end end
  get "profile/graphs", :to => "profiles#graphs", :as => "profile_graphs"
  resources :profiles,        only: [:index] do collection do get "json"; get "json_pno"  end end
  resources :names,           only: [:index] do collection do get "json"; get "json_pno"  end end
  resources :proper_names,    only: [:index] do collection do get "json"; get "json_pno"  end end
  resources :uploaded_checks, only: [:index] do collection do get "json"; get "json_pno"  end end
  get "privacy", :to => "top_page#privacy", :as => "privacy"
  root 'top_page#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
