module Message
  extend self

  def render(controller, action)
    options = {
      scope: "devise.#{controller}",
      default: [action.to_sym],
      resource_name: :user
    }

    I18n.t(options)
  end
end
