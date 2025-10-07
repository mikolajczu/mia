class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :access_denied_pundit

  def access_denied_pundit
    redirect_to root_path
  end
end
