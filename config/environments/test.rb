Meeple::Application.configure do
  config.action_controller.action_on_unpermitted_parameters = :raise
  config.action_controller.allow_forgery_protection         = false
  config.action_controller.perform_caching                  = false
  config.action_dispatch.show_exceptions                    = false
  config.action_mailer.default_url_options                  = { host: 'www.example.com' }
  config.action_mailer.delivery_method                      = :test
  config.active_support.deprecation                         = :stderr
  config.cache_classes                                      = true
  config.consider_all_requests_local                        = true
  config.eager_load                                         = false
  config.serve_static_files                                 = true
  config.static_cache_control                               = 'public, max-age=3600'
end
