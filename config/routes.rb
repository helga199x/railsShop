Rails.application.routes.draw do

  root 'main#index'
  get 'admin' => 'admins#admin'
  get 'admin/orders' => 'admins#orders'
  get 'admin/goods' => 'admins#goods'
  get 'admin/destroy' => 'admins#destroy'
  get 'admin/goods/update' => 'admins#update'
  get 'admin/goods/create' => 'admins#create'
  resources :admins

  get 'main' => 'main#accepted'
  post 'create' => 'main#create'

  get 'orders' => 'orders#show'
  post 'orders' => 'orders#updateStatus'

end
