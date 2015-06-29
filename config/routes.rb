Trough::Engine.routes.draw do
  resources :documents, path: "/", :except => :show do
    collection do
      get 'modal'
      post 'modal_create'
      get 'search'
      get 'autocomplete'
    end
    member do
      get 'info', :constraints => { :id => /.*/ }
    end
    get 'links' => 'document_usages#links'
    get 'stats' => 'document_usages#stats'
  end

  get '/*id', to: 'documents#show', format: false
end
