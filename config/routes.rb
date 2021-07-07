Rails.application.routes.draw do
  root 'main#index'
  get 'admin' => 'admin#adminPage'
  post 'create' => 'main#create'
  resource :orders
  resource :main
end
