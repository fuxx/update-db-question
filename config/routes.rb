# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  namespace :api, defaults: { format: :json } do
    namespace :app do
      namespace :v1 do
        # User
        get 'users/me', to: 'users#me' # User profile
        patch 'users/me', to: 'users#update' # update user
      end
    end
  end
end
