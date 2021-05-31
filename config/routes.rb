Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :courses do
    resources :lessons
    post 'order', on: :member
    get 'my_courses', on: :collection
  end
  resources :instructors

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
