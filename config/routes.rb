Rails.application.routes.draw do
  resources :bq_packages do
    resources :bqs
    post :publish
    post :unpublish

    get :published, on: :collection
  end

  resources :bq_types do
    resources :bq_packages
  end

  resources :bqs

  root to: "bq_packages#index"
end
