Rails.application.routes.draw do
  scope module: 'api' do
    namespace :v1 do
      # Return core lists
      get 'lists/today', to: 'lists#named_list', defaults: { id: 'today' }
      get 'lists/upcoming', to: 'lists#named_list', defaults: { id: 'upcoming' }
      get 'lists/someday', to: 'lists#named_list', defaults: { id: 'someday' }
      get 'lists/done', to: 'lists#named_list', defaults: { id: 'done' }

      # Login, return new JWT token
      post 'auth' => 'user_token#create'

      resources :lists
      resource :user, except: [:index, :destroy]
      resources :items, except: :index
    end
   end
end
