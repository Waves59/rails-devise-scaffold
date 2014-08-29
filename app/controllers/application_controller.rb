class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  respond_to :json

  rescue_from Exception do |e|
    uncaught_error(e)
  end

  def not_found
    error_info = {
      :error => "Not Found"
    }

    render :json => error_info.to_json, :status => 404
  end

  def uncaught_error(e)

   error_info = {
     :error => "Uncaught Error",
     :exception => "#{e.class.name} : #{e.message}",
   }
   error_info[:trace] = e.backtrace[0,10] if Rails.env.development?

   render :json => error_info.to_json, :status => 500
  end
end
