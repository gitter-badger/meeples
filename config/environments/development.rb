DevFuBase::Application.configure do
  config.action_controller.action_on_unpermitted_parameters = :raise
  config.action_controller.perform_caching                  = false
  config.action_dispatch.best_standards_support             = :builtin
  config.action_mailer.default_url_options                  = { host: 'localhost:8080' }
  config.action_mailer.delivery_method                      = :smtp
  config.action_mailer.raise_delivery_errors                = false
  config.action_mailer.smtp_settings                        = { address: 'localhost', port: 1025 }
  config.active_support.deprecation                         = :log
  config.assets.compress                                    = false
  config.assets.debug                                       = true
  config.cache_classes                                      = false
  config.consider_all_requests_local                        = true
  config.eager_load                                         = false
end
