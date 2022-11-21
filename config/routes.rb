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
    resources :addresses, only: [:new, :index, :edit, :create, :update, :destroy ]

    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :create, :update, :destroy ]


    # resource :customers, only: [:edit, :update ]
    get 'customers/my_page' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/reject_customer' => 'customers#reject_customer'

    root to: 'homes#top'
    get 'homes/about' => 'homes#about'

    resources :items, only: [:index, :show ]

    get 'orders/complete' => 'orders#complete'
    resources :orders, only: [:new, :create, :index, :show ]
    post 'orders/confirm' => 'orders#confirm'

    #resources :registrations, only: [:new, :create ]

    #resources :sessions, only: [:new, :create, :destroy ]
  end
  #管理者側のルーティング
  namespace :admin do

    resources :customers, only: [:index, :show, :edit, :update ]

    resources :genres, only: [:index, :edit, :create, :update ]

    get 'homes/top' => 'homes#top'

    resources :items, only: [:new, :show, :index, :edit, :create, :update ]

    resources :orders, only: [:show, :update ]

    resources :order_details, only: [:update ]

    #resources :sessions, only: [:new, :create, :destroy ]

  end
end
