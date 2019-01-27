Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'megasoft/home#index'
  namespace :megasoft do
    namespace :api do
      namespace :v1, defaults: { format: 'json' } do
         post 'calculator/calculate', to: 'calculator#calculate'
      end
    end

    namespace :admin do
      get '/', to: 'operator_usages#index'
      get '/get_report', to: 'operator_usages#get_report'
    end

  end

end
