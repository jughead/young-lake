class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied, with: :access_denied

  private

    def access_denied(exception)
      if user_signed_in?
        redirect_to root_path, alert: exception.message
      else
        session['user_return_to'] = request.fullpath
        flash[:alert] = 'Please sign in'
        redirect_to new_user_session_path
      end
    end
end
