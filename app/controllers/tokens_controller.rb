class TokensController < ApplicationController

  before_filter :authenticate_user!

  def index
    info = {
      token: true,
      id: 123
    }

    render json: info, status: 200
  end
end
