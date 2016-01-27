#encoding: utf-8
I18n.default_locale = :en

LANGUAGES = [
  ['English', 'en'],
  ["Espa&ntilde;ol".html_safe, 'es']
]

# [deprecated]
# I18n.enforce_available_locales will default to true in the future.
# If you really want to skip validation of your locale
# you can set I18n.enforce_available_locales = false to avoid this message.

# In order to silence the warning edit the application.rb file and include
# the following line inside the Rails::Application body (config/application.rb)
# I18n.enforce_available_locales = true
