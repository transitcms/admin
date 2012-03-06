Rails.application.routes.draw do
  namespace :transit do
    resources :contexts
  end
end