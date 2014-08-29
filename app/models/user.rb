class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
   # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable


  def reset_password_by_token(attributes={})
    original_token       = attributes[:reset_password_token]
    reset_password_token = Devise.token_generator.digest(self, :reset_password_token, original_token)
    recoverable = find_or_initialize_with_error_by(:reset_password_token, reset_password_token)

    if recoverable.persisted?
      if recoverable.reset_password_period_valid?
        recoverable.reset_password!(attributes[:password], attributes[:password_confirmation])
      else
        recoverable.errors.add(:reset_password_token, :expired)
      end
    end

    recoverable.reset_password_token = original_token
    recoverable
  end
end
