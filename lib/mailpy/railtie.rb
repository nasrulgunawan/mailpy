module Mailpy
  class Railtie < ::Rails::Railtie
    initializer 'mailpy.add_delivery_method', before: 'action_mailer.set_configs' do
      ActionMailer::Base.add_delivery_method(:mailpy, Mailpy::DeliveryMethod)
    end
  end
end
