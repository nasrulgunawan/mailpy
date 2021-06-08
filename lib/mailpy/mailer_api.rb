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
        to: mail.to.try(:join, ', '),
        cc: mail.cc.try(:join, ', '),
        bcc: mail.bcc.try(:join, ', '),
        from: mail.from.try(:join, ', '),
        options: eval(mail[:options].to_s),
        subject: mail.subject,
        body: body_data,
        attachment: attachment_data
      }
    end

    def body_data
      mail.body.parts.present? ? mail.body.parts[0].body.to_s : mail.body.to_s
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
