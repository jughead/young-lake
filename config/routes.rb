Rails.application.routes.draw do
  resources :events do
    post :store_filter, on: :collection
    get :use_stored_filter, on: :collection
  end
  devise_for :users
  root to: 'events#index'
end
