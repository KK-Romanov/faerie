Rails.application.routes.draw do
  # Admin side
  devise_for :admin,controllers: {
  sessions: "admin/sessions"
}
#skip: [:registrations, :passwords]  使用検討中
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :sessions, only: [:new, :create, :destroy] 
    # resources :recipes, only: [:show, :update]
    # resources :comments, only: [:show, :update]
    # resources :genres, only: [:index, :create, :edit, :update]

  end
  scope module: :admin do 
  resources :homes, only: [:top]
  get "/admin" => "homes#top", as: "top"
  end

#---------------------------------------------------------------------------
# User side
devise_for :users,controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
# 置き換え用。
# devise_for :users, controllers: {
#     registrations: 'users/registrations',
#     passwords: 'users/passwords'
#   }
#skip: [:passwords],   使用検討中
scope module: :public do 

      get "/users/my_page" => "users#show"
      get "/users/information/edit"  => "users#edit"
      patch "/users/information" => "users#update"
      get "/users/unsubscribe" => "users#unsubscribe", as: "unsubscribe"
      patch  "/users/withdraw" => "users#withdraw", as: "withdraw"
      # get 'users/favorites'
  resources :homes
   root to: 'homes#top'
   get "/about" => "homes#about", as: "about"
    # get 'recipes/tweet', to: "homes#tweet_index"
  resources :favorites, only: [:destroy, :create]  
  resources :comment, only: [:destroy, :create]  
  resources :recipes, only: [:new, :index, :edit, :update, :destroy, :create]
    # get 'recipes/tag_search'
     get 'recipes/tag/:name', to: "recipes#tag_search"
     get 'recipes/search', to: 'recipes#search'
    
#   devise_scope :public do
#     post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
#   end
  #users
    # get 'users/index'
    # get 'users/show'
    # get 'users/destroy'
    # get 'users/withdraw'
    # get 'users/unsubscribe'
    # get 'users/edit'
    
 
  end
end