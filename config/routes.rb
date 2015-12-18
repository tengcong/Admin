Rails.application.routes.draw do

  resources :photos
  resources :albums do
    resources :photos
    post :publish
    post :unpublish

    collection do
      get :search
    end

    get :published, on: :collection

    post :move_to
    patch :batch_move, on: :collection
    delete :batch_destroy, on: :collection
  end

  resources :bq_packages do
    resources :bqs
    post :publish
    post :unpublish

    collection do
      get :search
    end

    get :published, on: :collection

    post :move_to
    patch :batch_move, on: :collection
    delete :batch_destroy, on: :collection
  end

  resources :bq_types do
    resources :bq_packages
  end

  resources :bqs

  root to: "bq_packages#index"
end
