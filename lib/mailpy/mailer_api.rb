require 'httparty'

class MailerApi
  def initialize(mail, options = {})
    @mail = mail
    @options = options
  end

  def send
    result = HTTParty.post(
      options[:endpoint],
      body: form_data,
      headers: headers
    )
  end

  private
    attr_reader :mail, :options

    def form_data
      {
        ms_mailer: {
          to: mail.to.try(:join, ', '),
          cc: mail.cc.try(:join, ', '),
          bcc: mail.bcc.try(:join, ', '),
          from: mail.from.try(:join, ', '),
          subject: mail.subject,
          body: mail.body.parts[0].body.to_s,
          attachment: attachment_data
        }
      }
    end

    def attachment_data
      attachments = {}
      mail.attachments.each { |attachment| attachments[attachment.filename] = attachment.body }
      attachments
    end

    def headers
      options[:headers]
    end
end