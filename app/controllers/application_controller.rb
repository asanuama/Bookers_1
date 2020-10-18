class ApplicationController < ActionController::Base

  # devise利用の機能利用の際nameのデータ操作が許可される
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(resource.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end


  protected
  # deviseではsignup時にemailとpassword系のみを受け取るようストロングパラメーターが設けられてる
  # それ以外の:name などを許可したい場合、permitを設ける必要がある↓
  def configure_permitted_parameters
    added_attrs = [ :name, :email, :password, :password_confirmation　]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

end
