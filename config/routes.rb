Rails.application.routes.draw do
  # concern :listable do
  #   post :publish
  #   post :unpublish
  #   post :move_to
  #
  #   collection do
  #     get :search
  #     get :published
  #     patch :batch_move
  #     delete :batch_destroy
  #   end
  # end

  resources :photos
  resources :albums do
    resources :photos

    collection do
      get 'tags'
      get 'hot'
      get 'tagged_with/:tag' => 'albums#tagged_with'
    end




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

  resources :bqs
  resources :bq_packages do
    resources :bqs


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

  resources :bq_types do
    resources :bq_packages
  end

  root to: "home#index"
end
