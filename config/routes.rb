Rails.application.routes.draw do
  namespace :transit do
    resources :contexts,    :only => [:new, :destroy]
  end
end