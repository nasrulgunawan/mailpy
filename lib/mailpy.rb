require "mailpy/railtie"
require "mailpy/mailer_api"
require "mailpy/smtp_api"

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
      begin
        result = MailerApi.new(mail, settings).send
        raise(MailpyDeliveryError, JSON.parse(result.body)['message']) unless result.code === 200
        result
      rescue Errno::ECONNREFUSED, Mailpy::DeliveryMethod::MailpyDeliveryError
        smtp_settings = Rails.application.config.action_mailer.smtp_settings
        raise(MailpyDeliveryError, "SMTP miss configured. Please add SMTP configuration in your environment config") if smtp_settings.blank?
        result = SMTPApi.new(mail, smtp_settings).send
        result
      end
    end
  end
end
