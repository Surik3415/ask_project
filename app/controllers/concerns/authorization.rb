module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit::Authorization
    rescue_from Pundit::NotAuthorizedError, with: :not_authorized

    private

    def not_authorized
      flash[:danger] = 'You have no right to enter this page'
      redirect_to(request.referer || root_path)
    end
  end
end