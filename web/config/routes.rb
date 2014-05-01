Web::Application.routes.draw do
  get "sessions/create"
  get "sessions/destroy"
  root :to => 'opening_pages#welcome'
  match '/about',         to:   'opening_pages#about',      via: 'get'

  match '/sign_in',       to:   'sessions#sign_in',         via: 'get'
  match '/sign_in',       to:   'sessions#create',          via: 'post'
  match '/sign_out',      to:   'sessions#sign_out',        via: 'get'

  match '/sign_up',       to:   'users#new',                via: 'get'
  match '/sign_up',       to:   'users#create',             via: 'post'
  match '/select_artist', to:   'users#select_artist',      via: 'get'
end
