class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Wtf

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path
    flash[:danger] = "Sorry, you are not authorized to access this area!"
  end

  def new_session_path(scope)
    new_user_session_path
  end

  private

  def sign_up_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :username,
      :firstname,
      :lastname,
      :image,
      :url,
      :provider,
      :uid,
      :name,
      :oauth_token,
      :oauth_expires_at
      )
  end

  def account_update_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :current_password,
      :username,
      :firstname,
      :lastname,
      :image,
      :url
      )
  end

end




