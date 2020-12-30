require "mailpy/railtie"
require "mailpy/mailer_api"

module Mailpy
  class DeliveryMethod
    MailpyDeliveryError = Class.new(StandardError)
    
    attr_accessor :settings

    def initialize(params)
      self.settings = params
    end

    def deliver!(mail)
      perform_send_request(mail, settings)
    end

    private
    def perform_send_request(mail, settings)
      result = MailerApi.new(mail, settings).send
      raise(MailpyDeliveryError, JSON.parse(result.body)['message']) unless result.code === 200
      result
    end
  end
end
