Rails.application.routes.draw do

  resources :photos
  resources :albums do
    post :publish
    post :unpublish
    resources :photos
  end

  resources :bq_packages do
    resources :bqs
    post :publish
    post :unpublish

    get :published, on: :collection

    post :move_to
    delete :batch_destroy, on: :collection
    patch :batch_move, on: :collection
  end

  resources :bq_types do
    resources :bq_packages
  end

  resources :bqs

  root to: "bq_packages#index"
end
