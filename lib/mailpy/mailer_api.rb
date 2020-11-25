require 'httparty'

class MailerApi
  attr_reader :options, :message

  def initialize(options, message)
    @options = options
    @message = message
  end

  def send
    send_email
  end

  private
  def send_email
    result = HTTParty.post(
      options[:endpoint],
      body: {
        sender_email: options[:sender], 
        recipient_email: options[:to], 
        cc_email: options[:cc],
		    bcc_email: options[:bcc], 
        subject_email: options[:subject], 
        message_email: message
      }.to_json,
      
      headers: {
        'Content-Type': 'application/json',
        'Authorization': options[:token].to_s
      }
    )    
  end
end