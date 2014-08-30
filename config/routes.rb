Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'devise/sessions',
    confirmations: 'devise/confirmations',
    registrations: 'devise/registrations',
    passwords: 'devise/passwords'
  }, defaults: { format: :json }

  resources :tokens, defaults: { format: :json }

  root to: "application#root", via: :all
  get "/csrf" => "application#blank", via: :all
  match "400" => "application#error", via: :all
  match "*path" => "application#not_found", via: :all

end
