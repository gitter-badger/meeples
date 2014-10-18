Meeple::Application.routes.draw do

  resources :games, only: %i[ index show ] do
    resources :plays, only: %i[ new create show ], shallow: true
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  ActiveAdmin.routes self

  root to: 'welcome#index'

end
