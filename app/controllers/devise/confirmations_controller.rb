class Devise::ConfirmationsController < DeviseController
  # GET /resource/confirmation/new
  def new
    self.resource = resource_class.new
  end

  # POST /resource/confirmation
  def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      render json: resource, status: 200
    else
      render json: resource, status: 200
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      sign_in(resource_name, resource)
      data = JSON.parse(resource.to_json)
      data[:msg] = Message.render("confirmations", "confirmed")
      render json: resource, status: 200
    else
      render json: resource.errors, status: 400
    end
  end

end
