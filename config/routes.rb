Meeple::Application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  ActiveAdmin.routes self

  resources :games, only: %i[ index show ] do
    resources :plays, only: %i[ new create show ], shallow: true
  end

  resources :users, only: %i[ show ]

  resources :users,       only: [:index]
  resources :friendships, only: [:index, :create]

  root to: 'welcome#index'

end
