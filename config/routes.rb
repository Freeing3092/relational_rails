Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/libraries', to: 'libraries#index'
  get '/libraries/new', to: 'libraries#new'
  get '/libraries/:id', to: 'libraries#show'
  get '/libraries/:id/books', to: 'libraries#library_books'
  
  get '/books', to: 'books#index'
  get '/books/:id', to: 'books#show'
  post '/libraries/new', to: 'libraries#create'
  
  get 'libraries/:id/edit', to: 'libraries#edit'
  
  patch '/libraries/:id/edit', to: 'libraries#update'
end
