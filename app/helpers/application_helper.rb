# frozen_string_literal: true

module ApplicationHelper
  def map_locale_names
    I18n.available_locales.index_by { |lang| t(lang.to_s, locale: locale) }
  end
end
