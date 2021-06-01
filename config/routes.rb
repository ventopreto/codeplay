Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  namespace :admin do
    resources :instructors
    resources :courses do
      resources :lessons
    end

    
  end
  resources :instructors, only: %i[show index]
  resources :courses, only: %i[show index]  do
    resources :lessons, only:  %i[show index] 
    post 'order', on: :member
    get 'my_courses', on: :collection
  end

end
