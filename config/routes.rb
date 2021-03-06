Meeple::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :games, only: %i[ index show new create] do
    get :recently_viewed, :on => :collection
    resources :plays, only: %i[ new create show ], shallow: true do
      get :autocomplete_user_usernames, :on => :collection
    end
    resource :flag_games, only: %i[ new create ], path: 'flag'
  end

  resources :users, only: %i[ index show ] do
    get 'games' => 'users#games'
  end

  resources :plays, only: %i[ index destroy ] do
    resources :comments, only: [:create]
  end

  resources :friendships, only: %i[ index create ]

  resource :activities, only: %i[ index ]

  authenticated :user do
    root to: 'activities#index', as: 'authenticated_root'
  end
  root to: 'welcome#index'
end
