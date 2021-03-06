class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name profile icon icon_cache])
  end

  def redirect_back_to_request(err_msg)
    redirect_back(fallback_location: request.url)
    flash[:danger] = err_msg
  end

  def search_result_is_present?(index)
    flash.now[:danger] = "検索結果がありませんでした"  unless index.present?
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

end
