# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit::Authorization
    rescue_from Pundit::NotAuthorizedError, with: :not_authorized

    private

    def not_authorized
      flash[:danger] = t '.flash.not_authirize'
      redirect_to(request.referer || root_path)
    end
  end
end
