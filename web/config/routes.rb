Web::Application.routes.draw do
  root :to => 'opening_pages#welcome'
  match '/about',    to:   'opening_pages#about',     via: 'get'

  match '/signin',   to:   'users#sign_in_form',      via: 'get'
  match '/sign_in',  to:   'users#sign_in',           via: 'post'
  match '/signup',   to:   'users#new',               via: 'get'
  match '/signout',  to:   'users#signout',           via: 'get'
  match '/signup',   to:   'users#create',            via: 'post'
  match '/select_artist', to:  'users#select_artist', via: 'get'
end
