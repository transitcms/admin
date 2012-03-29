Rails.application.routes.draw do
  namespace :transit do
    resources :contexts
    resources :uploads, controller: 'assets'
  end
end