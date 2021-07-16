Rails.application.routes.draw do
  root 'main#index'
  get 'admin' => 'admins#admin'
  get 'main' => 'main#accepted'
  post 'create' => 'main#create'
  get 'orders' => 'orders#show'
  post 'orders' => 'orders#updateStatus'
end
