Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  namespace :admin do
    resources :courses

    
  end
  resources :courses, only: %i[show index]  do
    resources :lessons
    post 'order', on: :member
    get 'my_courses', on: :collection
  end
  resources :instructors
end
