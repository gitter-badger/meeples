require 'hirb'
require 'active_support'

# ActiveSupport.on_load :active_record do
#   Hirb::Helpers::Table.filter_classes.merge!({ ActiveSupport::TimeWithZone => :words_ago, Time => :words_ago })
# end

old_print = Pry.config.print
Pry.config.print = proc do |*args|
  Hirb::View.view_or_page_output(args[1]) || old_print.call(*args)
end

Hirb.enable
extend Hirb::Console
