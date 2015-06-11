Trough::Engine.routes.draw do
  resources :documents, path: "/", :except => :show
  get '/*id', to: 'documents#show', format: false
end
