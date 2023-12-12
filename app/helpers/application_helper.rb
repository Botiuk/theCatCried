module ApplicationHelper
    def map_locale_names
        I18n.available_locales.map { |lang| [t("#{lang}", locale: locale), lang] }.to_h
    end
end
