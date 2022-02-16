class RegistrationsController < Devise::RegistrationsController
  protected

  def after_inactive_sign_up_path_for(_resource)
    user_session_path
  end
end
