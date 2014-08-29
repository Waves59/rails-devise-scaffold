Rails.application.routes.draw do
  devise_for :users

  match "*path" => "application#not_found", via: :all

end
