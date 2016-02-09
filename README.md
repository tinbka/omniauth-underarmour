# OmniAuth UnderArmour Strategy

This gem is an OmniAuth 1.0+ Strategy for the [UnderArmour API](https://developer.underarmour.com/docs/v71_OAuth_2_Intro).

## Usage

Add the strategy to your `Gemfile`:

```ruby
gem 'omniauth-underarmour'
```

Then integrate the strategy into your middleware:

```ruby
use OmniAuth::Builder do
  provider :underarmour, 'consumer_key', 'consumer_secret'
end
```

In Rails, create a new file under config/initializers called omniauth.rb to plug the strategy into your middleware stack.

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :underarmour, 'consumer_key', 'consumer_secret'
end
```

For usage with Devise go to [Facebook Example at Devise wiki](https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview#facebook-example).

To register your application with Fitbit and obtain a consumer key and secret, go to the [UnderArmour Mashery ID registration](https://developer.underarmour.com/member/register).

For additional information about OmniAuth, visit [OmniAuth wiki](https://github.com/intridea/omniauth/wiki).

For a short tutorial on how to use OmniAuth in your Rails application, visit [this tutsplus.com tutorial](http://net.tutsplus.com/tutorials/ruby/how-to-use-omniauth-to-authenticate-your-users/).
