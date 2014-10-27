# -*- encoding: utf-8 -*-

if RUBY_VERSION < "1.9"
  $KCODE = 'u'
end

require 'i18n'

require 'polish/version'

# Rails hacks
if defined?(ActionView::Helpers)
  require 'polish/action_view_ext/helpers/date_helper'
end

require 'polish/proxies'

module Polish
  extend self

  begin
    require 'i18n-js'

    if defined? ::Rails::Engine
      # auto wire assets as Rails Engine
      class Rails < ::Rails::Engine
      end

    elsif defined? ::Sprockets
      root_dir = File.expand_path '../..', __FILE__

      # Set up asset paths for Sprockets apps
      ::Sprockets.append_path File.join(root_dir, 'lib', 'assets', 'javascripts')
    end
  rescue
    # No i18n-js gem found
  end

  # Polish locale
  LOCALE = :pl

  # Polish locale
  def locale
    LOCALE
  end

  # Regexp machers for context-based month names and day names translation
  LOCALIZE_STANDALONE_ABBR_DAY_NAMES_MATCH = /^%a/
  LOCALIZE_STANDALONE_DAY_NAMES_MATCH = /^%A/
  LOCALIZE_ABBR_MONTH_NAMES_MATCH = /(%[-\d]?d|%e)(.*)(%b)/
  LOCALIZE_MONTH_NAMES_MATCH = /(%[-\d]?d|%e)(.*)(%B)/

  # Init Polish i18n: set custom backend,
  # load all translations shipped with library.
  def init_i18n
    I18n.backend.class.send(:include, I18n::Backend::Pluralization)
    I18n.load_path.unshift(*locale_files)

    I18n.reload!
  end

  protected
    # Returns all locale files shipped with library
    def locale_files
      Dir[File.join(File.dirname(__FILE__), "polish", "locale", "**/*")]
    end
end

Polish.init_i18n
