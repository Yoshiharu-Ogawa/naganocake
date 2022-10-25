Rails.application.routes.draw do

# 顧客用
# URL /customers/sign_in ...
devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #会員側のルーティング
  scope module: :public do
    resources :addresses, only: [:new, :create, :destroy ]

    resources :cart_items, only: [:index, :create, :update, :destroy ]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'

    resources :customers, only: [:show, :edit, :update ]
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/reject_user' => 'customers#reject_user'

    root to: 'homes#top'
    get 'homes/about' => 'homes#about'

    resources :items, only: [:index, :show ]

    resources :orders, only: [:new, :create, :index, :show ]
    get 'orders/complete' => 'orders#complete'
    post 'orders/confirm' => 'orders#confirm'

    #resources :registrations, only: [:new, :create ]

    #resources :sessions, only: [:new, :create, :destroy ]
  end
  #管理者側のルーティング
  namespace :admin do

    resources :customers, only: [:index, :show, :edit, :update ]

    resources :genres, only: [:index, :edit, :create, :update ]

    resources :homes, only: [:top ]

    resources :items, only: [:new, :show, :index, :edit, :create, :update ]

    resources :orders, only: [:show, :update ]

    resources :order_details, only: [:update ]

    #resources :sessions, only: [:new, :create, :destroy ]

  end
end
