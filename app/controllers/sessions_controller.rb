class SessionsController < Devise::SessionsController

  def create
    super
    ap "hello"
  end

  def destroy
    super
  end

end
