Meeple::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :games, only: %i[ index show ] do
    get :recently_viewed, :on => :collection
    resources :plays, only: %i[ new create show ], shallow: true do
      get :autocomplete_user_usernames, :on => :collection
    end
  end

  resources :users, only: %i[ index show ] do
    get 'games' => 'users#games'
  end

  resources :plays, only: %i[ index ] do
    resources :comments, only: [:create]
  end

  resources :friendships, only: %i[ index create ]

  root to: 'welcome#index'
end
