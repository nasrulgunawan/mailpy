# Mailpy
Action Mailer Adapter for Send Email Through HTTP APIs.

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
config.action_mailer.mailpy_settings = {
	endpoint: ENV['MAILER_API_ENDPOINT'],
	headers: {
	  Authorization: ENV['MAILER_API_KEY_OR_AUTH_TOKEN']
	}
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
