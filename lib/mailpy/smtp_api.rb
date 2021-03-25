class SMTPApi < ActionMailer::Base
  def initialize(mail, options = {})
    @mail = mail
    @options = options
  end

  def send
		mail.delivery_method :smtp, options
    mail.deliver!
  end

  private
    attr_reader :mail, :options
end