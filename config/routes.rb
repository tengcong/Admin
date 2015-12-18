Rails.application.routes.draw do

  concern :listable do
    post :publish
    post :unpublish
    post :move_to

    collection do
      get :search
      get :published
      patch :batch_move
      delete :batch_destroy
    end
  end

  resources :photos
  resources :albums, concerns: :listable do
    resources :photos
  end

  resources :bqs
  resources :bq_packages, concerns: :listable do
    resources :bqs
  end

  resources :bq_types do
    resources :bq_packages
  end

  root to: "bq_packages#index"
end
