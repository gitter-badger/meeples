module PermissionsMatcher

  RSpec::Matchers.define :allow_access do

    chain(:to) { |who| @who = who }

    def login_and_visit
      login_as send(@who) unless @who == :guest
      visit path
    end

    def role
      @who ? @who : :guest
    end

    def helper_from path
      hash = Rails.application.routes.recognize_path path
      "#{ hash[:controller] }##{ hash[:action] }"
    rescue
      path
    end

    match     { login_and_visit ; current_path == path }
    match_when_negated { login_and_visit ; current_path != path }

    description do
      "allow #{ role.inspect } to access #{ helper_from path }"
    end

    failure_message do
      "#{ role.inspect } should be able to access #{ helper_from path }"
    end

    failure_message_when_negated do
      "#{ role.inspect } should not be able to access #{ helper_from path }"
    end

  end

end
