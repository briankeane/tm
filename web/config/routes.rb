Web::Application.routes.draw do
  get "users/new"
  root :to => 'opening_pages#welcome'
  match '/about',      to: 'opening_pages#about',    via: 'get'
  match '/signin',    to: 'opening_pages#sign_in',  via: 'get'
  match '/signup',    to: 'users#new',               via: 'get'
end
