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
    
        unless result.code === 200
          message = begin
            JSON.parse(result.body)['message']
          rescue JSON::ParserError
            Rails.logger.error("Mailpy response is not JSON: #{result.body[0..300]}")
            "Unexpected response from Mailpy: #{result.body[0..100]}"
          end
          raise(MailpyDeliveryError, message)
        end

        result
      rescue Errno::ECONNREFUSED, Mailpy::DeliveryMethod::MailpyDeliveryError, Errno::ECONNRESET
        smtp_settings = Rails.application.config.action_mailer.smtp_settings
        raise(MailpyDeliveryError, "SMTP miss configured. Please add SMTP configuration in your environment config") if smtp_settings.blank?
        result = SMTPApi.new(mail, smtp_settings).send
        result
      end
    end
  end
end
