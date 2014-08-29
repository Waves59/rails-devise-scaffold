Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'devise/sessions',
    confirmations: 'devise/confirmations',
    registrations: 'devise/registrations',
    passwords: 'devise/passwords'
  }

  resources :tokens

  root to: "application#not_found", via: :all
  match "*path" => "application#not_found", via: :all

end
