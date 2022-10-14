Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/libraries', to: 'libraries#index'
  get '/libraries/:id', to: 'libraries#show'
  get '/libraries/:id/books', to: 'libraries#library_books'
  
  get '/books', to: 'books#index'
  get '/books/:id', to: 'books#show'
end
