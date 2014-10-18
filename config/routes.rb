DevFuBase::Application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

   ActiveAdmin.routes self

  root to: 'welcome#index'

end
