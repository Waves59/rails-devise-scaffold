class ApplicationController < ActionController::Base
  before_filter :api_settings
  respond_to :json

  if Rails.env.production?
    protect_from_forgery with: :exception
    before_filter :set_csrf_cookie_for_ng
  end

  def api_settings
    request.format = :json
  end

  rescue_from Exception do |e|
    uncaught_error(e)
  end

  def root
    render json: {
      msg: "redirected to root"
    }, status: 400
  end

  def not_found
    error_info = {
      error: "Not Found"
    }

    render json: error_info.to_json, status: 404
  end

  def uncaught_error(e)

   error_info = {
     error: "Uncaught Error",
     exception: "#{e.class.name} : #{e.message}",
   }
   error_info[:trace] = e.backtrace[0,10] if Rails.env.development?

   render json: error_info.to_json, status: 500
  end

  protected

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end
end
