Web::Application.routes.draw do
  root :to => 'opening_pages#welcome'
  get "opening_pages/about"
  get "opening_pages/sign_in"
  get "opening_pages/sign_up"
end
