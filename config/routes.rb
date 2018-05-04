Rails.application.routes.draw do

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  resources :seeks 
  delete 'accept_seek/:id', as: 'accept_seek', to: 'seeks#accept'

  resources :games
  resources :seeklists
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations' },
                     path_names: { sign_in: 'login', sign_out: 'logout' }

  root to: 'static_pages#home'
  get '/lobby', to: 'static_pages#lobby'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
