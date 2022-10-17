Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/libraries', to: 'libraries#index'
  get '/libraries/new', to: 'libraries#new'
  get '/libraries/:id', to: 'libraries#show'
  get '/libraries/:id/books', to: 'libraries#library_books'
  get '/libraries/:id/sort_books', to: 'libraries#sort_library_books'
  get '/libraries/:id/books/new', to: 'books#new'
  
  get '/books', to: 'books#index'
  get '/books/:id', to: 'books#show'
  get '/books/:id/edit', to: 'books#edit'
  patch '/books/:id/edit', to: 'books#update'
  
  post '/libraries/:id/books/new', to: 'books#create'
  
  post '/libraries/new', to: 'libraries#create'
  
  get 'libraries/:id/edit', to: 'libraries#edit'
  
  patch '/libraries/:id/edit', to: 'libraries#update'
end
