Rails.application.routes.draw do
  root 'main#index'
  get 'admin' => 'admin#adminPage'
end
