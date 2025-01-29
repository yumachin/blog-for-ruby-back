Rails.application.routes.draw do
  namespace :api do
    # resources :blogsとすることで BlogsController を参照
    # api/blogsというURLをリクエストしたとき(HTTPメソッドはGET)、indexアクションが実行
    resources :blogs, only: [:index, :show, :create, :update, :destroy]
  end
end