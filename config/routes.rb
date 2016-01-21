Rails.application.routes.draw do
  root "home#index"

  namespace :admin do
    # vr #
    resources :articles do
      collection do
        get 'scrawler_page'
        post 'crawl'
      end
    end
    resources :site_categories
    resources :site_types
    resources :sites do
      post :move_to
      collection do
        patch :batch_move
        delete :batch_destroy
      end
    end
    # vr #

    concern :listable do
      post :publish
      post :unpublish
      post :move_to
      post 'batch_upload'

      collection do
        get 'tags'
        get :search
        get :published
        patch :batch_move
        delete :batch_destroy

        patch :batch_publish
        patch :batch_unpublish
      end
    end

    resources :photos
    resources :albums, concerns: :listable do
      resources :photos

      collection do
        get 'hot'
        get 'tagged_with/:tag' => 'albums#tagged_with'
      end
    end

    resources :bqs
    resources :bq_packages, concerns: :listable do
      resources :bqs
      collection do
        get 'tagged_with/:tag' => 'bq_packages#tagged_with'
      end
    end

    resources :bq_types do
      resources :bq_packages
    end

    root to: "home#index"
  end
end
