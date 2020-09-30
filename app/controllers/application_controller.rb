class ApplicationController < ActionController::Base
  # ログイン済ユーザーのみにアクセスを許可(ログインしてないと、ログイン画面へリダイレクト)
  before_action :authenticate_user!

  # devise利用の機能利用（sign_up）の際nameのデータ操作が許可される
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
