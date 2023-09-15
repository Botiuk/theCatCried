Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    get 'reports', to: 'reports#index'
    get 'reports/report_by_category', to: 'reports#report_by_category'
    get 'reports/report_by_dates', to: 'reports#report_by_dates'
    get '/search', to: 'operations#search'
    get 'main/index', to: 'main#index'
    resources :operations
    resources :categories

    root "main#index"
  end
  
end
