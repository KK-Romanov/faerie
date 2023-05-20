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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
