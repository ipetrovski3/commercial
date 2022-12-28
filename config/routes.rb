Rails.application.routes.draw do
  resources :reports
  get '/reports/period', to: 'reports#period'
  get 'reports/by_season', to: 'reports#by_season'
  resources :products, except: :show do
    collection do
      get :brands
      get :search
      get :invoiced
    end
  end

  namespace :products do
    resources :tires do
      collection do
        get :dimensions
      end
    end
    resources :services
    resources :others
  end

  root 'dashboard#index'
  devise_for :users
  resources :invoices
  resources :categories
  resources :incoming_invoices
  resources :customers do
    collection do
      get :invoiced
      get :list
    end
  end
end
