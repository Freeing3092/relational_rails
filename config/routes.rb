Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/libraries', to: 'libraries#index'
  get '/libraries/:id', to: 'libraries#show'
  get '/libraries/:id/child_table_name', to: 'libraries#child_show'
  
  get '/child_table_name', to: 'childs#index'
  get '/child_table_name/:id', to: 'childs#show'
end
