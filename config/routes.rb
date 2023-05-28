Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'users/update'
  end
  namespace :public do
    get 'favorites/create'
    get 'favorites/destroy'
  end
  namespace :public do
    get 'comment/create'
    get 'comment/destroy'
  end
  namespace :public do
    get 'recipes/index'
    get 'recipes/edit'
    get 'recipes/update'
    get 'recipes/new'
    get 'recipes/destroy'
    get 'recipes/tag_search'
  end
  namespace :public do
    get 'users/index'
    get 'users/show'
    get 'users/destroy'
    get 'users/favorites'
    get 'users/withdraw'
    get 'users/unsubscribe'
    get 'users/edit'
  end
  devise_for :admin,controllers: {
  sessions: "admin/sessions"
}
#skip: [:registrations, :passwords]  使用検討中

#---------------------------------------------------------------------------
 
devise_for :users,controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
#skip: [:passwords],   使用検討中
scope module: :public do 
   get "/customers/my_page" => "customers#show"
      get "/customers/information/edit"  => "customers#edit"
      patch "/customers/information" => "customers#update"
      get "/customers/unsubscribe" => "customers#unsubscribe", as: "unsubscribe"
      patch  "/customers/withdraw" => "customers#withdraw", as: "withdraw"
  resources :homes
   root to: 'homes#top'
   get "/about" => "homes#about", as: "about"
end
end