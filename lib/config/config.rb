# frozen_string_literal: true

if ENV['DEV_MODE'] == '1'
  LowType.configure do |config|
    config.output_mode = :value
  end
end
