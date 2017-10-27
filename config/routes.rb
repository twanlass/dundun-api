Rails.application.routes.draw do
  scope module: 'api' do
    namespace :v1 do
      resources :items, except: :index
      resources :lists

      # Create new user
      post 'user' => 'user#create'

      # Return current user info
      get 'user' => 'user#show'

      # Login, return new JWT token
      post 'auth' => 'user_token#create'
    end
   end
end
