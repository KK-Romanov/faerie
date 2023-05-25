Rails.application.routes.draw do
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