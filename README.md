# Mailpy
Action Mailer Adapter for Sending Email Through HTTP APIs. Mailpy will automatically switch to SMTP method in case your mailer server encounter any problem.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'mailpy'
```

Add configuration to your application environments. development.rb, staging.rb, or production.rb

```ruby
config.action_mailer.delivery_method = :mailpy
config.action_mailer.perform_deliveries = true
config.action_mailer.raise_delivery_errors = true
config.action_mailer.mailpy_settings = {
	endpoint: ENV['MAILER_API_ENDPOINT'],
	headers: {
	  Authorization: ENV['MAILER_API_KEY_OR_AUTH_TOKEN']
	}
}
config.action_mailer.smtp_settings = {
	address: ENV['SMTP_ADDRESS'],
	port: ENV['SMTP_PORT'],
	domain: ENV['SMTP_DOMAIN'],
	authentication: ENV['SMTP_AUTHENTICATION_METHOD'],
	user_name: ENV['SMTP_USERNAME'],
	password: ENV['SMTP_PASSWORD'],
	enable_starttls_auto: true,
	openssl_verify_mode: 'none'
}
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install mailpy
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
