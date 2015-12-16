Rails.application.routes.draw do
  resources :bq_packages do
    resources :bqs
  end

  resources :bq_types do
    resources :bq_packages
  end

  root to: "bq_types#index"
  resources :bqs
end
