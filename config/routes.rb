Rails.application.routes.draw do
  get 'songs/index'

  get 'songs/show'

  get 'songs/new'

  get 'songs/create'

  get 'songs/edit'

  get 'songs/update'

  get 'songs/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :songs 
end
