Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/parents', to: 'parents#index'
  get '/parents/:id', to: 'parents#show'
  
  get '/child_table_name', to: 'childs#index'
end
