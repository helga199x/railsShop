Rails.application.routes.draw do
  root 'main#index'
  post 'create' => 'main#create'
  get 'orders' => 'orders#show'
  post 'orders' => 'orders#updateStatus'
  
end
