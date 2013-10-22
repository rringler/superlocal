Superlocal::Application.routes.draw do
	devise_for :user

  root  'pages#home'
  match '/user/:id', to: "users#show",
  									 via: [:get],
  									 as: 'user'
end
