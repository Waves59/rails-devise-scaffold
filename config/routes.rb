Rails.application.routes.draw do
  devise_for :users

  root to: "application#not_found", via: :all
  match "*path" => "application#not_found", via: :all

end
