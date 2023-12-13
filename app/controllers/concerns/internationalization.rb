module Internationalization
  extend ActiveSupport::Concern

  included do
    before_action :set_locale

    private

    def set_locale
      I18n.locale = (current_user.favorite_locale if user_signed_in?) || params[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
    end

    def extract_locale_from_accept_language_header
      if request.env['HTTP_ACCEPT_LANGUAGE']
        parsed_locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/)[0]
        I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
      end
    end

    def default_url_options
      { locale: I18n.locale }
    end

  end

end
