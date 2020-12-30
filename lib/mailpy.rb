require "mailpy/railtie"
require "mailpy/mailer_api"

module Mailpy
  class DeliveryMethod
    attr_accessor :settings

    def initialize(params)
      self.settings = params
    end

    def deliver!(mail)
      MailerApi.new(mail, settings).send
    end
  end
end
