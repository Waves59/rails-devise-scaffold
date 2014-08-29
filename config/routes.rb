Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions',
    confirmations: 'confirmations',
    registrations: 'registrations',
    passwords: 'passwords'
  }

  root to: "application#not_found", via: :all
  match "*path" => "application#not_found", via: :all

end
