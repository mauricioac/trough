Trough::Engine.routes.draw do
  resources :documents, path: "/", :except => :show do
    collection do
      get 'modal'
      post 'modal_create'
    end
  end

  get '/*id', to: 'documents#show', format: false
end
