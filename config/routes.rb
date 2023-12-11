Rails.application.routes.draw do
  resources :items do
    member do
      patch 'soft_delete'
      patch 'restore'
    end
  end
end
