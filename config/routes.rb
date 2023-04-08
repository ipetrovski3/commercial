Rails.application.routes.draw do
  root 'products#index'

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

  get '/document', to: 'documents#document_number_by_warehouse'

  namespace :products do
    resources :tires do
      collection do
        get :dimensions
        get :brands
        get :patterns
      end
    end
    resources :services
    resources :others do
      collection do
        get :brands
        get :patterns
      end
    end
  end

  resources :warehouses, only: %i[index destroy]

  devise_for :users
  resources :invoices
  resources :categories
  resources :incoming_invoices
  resources :issue_slips
  resources :brands
  resources :patterns

  resources :customers do
    collection do
      get :invoiced
      get :list
    end
  end

  resources :hotels
end
