# frozen_string_literal: true

# Service to create a default non-privileged user.
class CreateUserService
  USER_ATTRS = {
    name: Rails.application.secrets.user_name,
    password: Rails.application.secrets.user_password,
    password_confirmation: Rails.application.secrets.user_password
  }.freeze

  # Do the thing.
  def call
    return User.user.first if User.user.count.positive?

    User.find_or_create_by! email: Rails.application.secrets.user_email do |u|
      u.assign_attributes USER_ATTRS
      u.confirm
    end
  end
end
