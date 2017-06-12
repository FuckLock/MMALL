# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

ENV['ALIPAY_PID'] = '2016080700185738'
ENV['ALIPAY_MD5_SECRET'] = '5o1iuxgxze13lq2hq71tq9j38i7xi4p3'
ENV['ALIPAY_URL'] = 'https://openapi.alipay.com/gateway.do'
ENV['ALIPAY_RETURN_URL'] = 'http://localhost:3000/payments/pay_return'
ENV['ALIPAY_NOTIFY_URL'] = 'http://localhost:3000/payments/pay_notify'

module MasterRailsByActions
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += %W[#{Rails.root}/lib]
    config.generators do |generator|
      generator.assets false
      generator.helper false
      generator.test_framework = :rspec
      generator.skip_routes true
      generator.fixture_replacement :factory_girl
      generator.factory_girl dir: 'spec/factories'
    end
  end
end
