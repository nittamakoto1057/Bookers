Rails.application.routes.draw do
  get '/home/about', to: 'books#about'
  root 'books#top'
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:top, :create, :index, :show, :edit, :update, :destroy]
end
