Rails.application.routes.draw do
#   get 'review/createdestroy'
  # Admin side
  devise_for :admin,controllers: {
  sessions: "admin/sessions"
}
#skip: [:registrations, :passwords]  使用検討中
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :sessions, only: [:new, :create, :destroy] 
    resources :recipe, only: [:index, :show, :edit, :update, :destroy]
    resources :comment, only: [:index, :show, :edit, :update, :destroy]
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
   resources :users, only: [:index , :update]
      get "/users/:id/my_page" => "users#show", as: "my_page"
      get "/users/information/:id/edit" => "users#edit", as: "information_edit"
      patch "/users/information/:id" => "users#update", as: "information"
      get "/users/unsubscribe/:id" => "users#unsubscribe", as: "unsubscribe"
       patch  "/users/withdraw" => "users#withdraw", as: "withdraw"
      # get 'users/favorites'
  resources :homes
   root to: 'homes#top'
   get "/about" => "homes#about", as: "about"
    # get 'recipes/tweet', to: "homes#tweet_index"
  resources :recipes, only: [:new, :index, :edit, :update, :destroy, :create, :show] do
    resources :comments, only: [:destroy, :create]
    resource :favorites, only: [:destroy, :create]  
    resources :reviews, only: %w[create destroy]
   
   end
    # get 'recipes/tag_search'
     get 'recipes/tag/:name', to: "recipes#tag_search"
     get 'recipes/search', to: 'recipes#search'
    
  devise_scope :user do
    post 'guest_sign_in', to: 'sessions#guest_sign_in'
  end
  #users
    # get 'users/index'
    # get 'users/show'
    # get 'users/destroy'
    # get 'users/withdraw'
    # get 'users/unsubscribe'
    # get 'users/edit'
    
 
  end
end