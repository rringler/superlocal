Superlocal::Application.routes.draw do
	devise_for :users

	resources :boards do
		resources :posts
	end

  root  'pages#home'
  match '/user/:id',   to: "users#show",
  									   via: [:get],
  									   as: 'user'
  match 'boards/find', to: "boards#find",
  										 via: [:post],
  										 as: 'find_board'
end
