Rails.application.routes.draw do
  resources :battle_rankings,      only: [:index] do collection do get "json"; get "pno_text" end end
  resources :raid_rewards,         only: [:index] do collection do get "json"; get "pno_text" end end
  resources :pk_pkks,              only: [:index] do collection do get "json"; get "pno_text" end end
  resources :ranks,                only: [:index] do collection do get "json"; get "pno_text" end end
  resources :battle_results,       only: [:index] do collection do get "json"; get "pno_text" end end
  resources :next_battle_infos,    only: [:index] do collection do get "json"; get "pno_text" end end
  resources :teach_spells,         only: [:index] do collection do get "json"; get "pno_text" end end
  resources :spell_thread_members, only: [:index] do collection do get "json"; get "pno_text" end end
  resources :spell_threads,        only: [:index] do collection do get "json"; get "pno_text" end end
  resources :parties,              only: [:index] do collection do get "json"; get "pno_text" end end
  resources :party_infos,          only: [:index] do collection do get "json"; get "pno_text" end end
  resources :tuning_abilities,     only: [:index] do collection do get "json"; get "pno_text" end end
  resources :obsolescences,        only: [:index] do collection do get "json"; get "pno_text" end end
  resources :spells,               only: [:index] do collection do get "json"; get "pno_text" end end
  resources :tune_gem_data,        only: [:index] do collection do get "json"; get "pno_text" end end
  resources :spell_data,           only: [:index] do collection do get "json"; get "pno_text" end end
  resources :items,                only: [:index] do collection do get "json"; get "pno_text" end end
  get "equip/graphs", :to => "equips#graphs", :as => "equip_graphs"
  resources :equips,               only: [:index] do collection do get "json"; get "pno_text"; get 'graphs' end end
  resources :statuses,             only: [:index] do collection do get "json"; get "pno_text" end end
  get "profile/graphs", :to => "profiles#graphs", :as => "profile_graphs"
  resources :profiles,             only: [:index] do collection do get "json"; get "pno_text"; get 'graphs' end end
  resources :names,                only: [:index] do collection do get "json"; get "pno_text" end end
  resources :proper_names,         only: [:index] do collection do get "json"; get "pno_text" end end
  resources :uploaded_checks,      only: [:index] do collection do get "json"; get "pno_text" end end
  get "privacy", :to => "top_page#privacy", :as => "privacy"
  root 'top_page#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
