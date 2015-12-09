![alt text](http://www.hitfoxgroup.com/downloads/hitfox_logo_with_tag_two_colors_WEB.png "Logo Hitfox Group")


messagebird-sms
=======


Description
-----------

Send text messages by means of the HTTP protocol with the service of https://www.messagebird.com, from your ruby app.
​
Usage
------------

### Configuration

Use `MessagebirdTexter.configure` to set `product_token`, `endpoint` and `path`

```ruby
MessagebirdTexter.configure do |config|
  config.product_token = 'YOUR_MESSAGEBIRD_API_TOKEN'
  config.endpoint = 'https://rest.messagebird.com' # Messagebird default
  config.path = '/messages' # Messagebird default
end
```

Create a class that is inherited from `MessagebirdTexter::Messenger`.

```ruby
class TextMessageNotifier < MessagebirdTexter::Messenger
end
```

Now you can add your first welcome message.
This can be as simple as:

```ruby
class TextMessageNotifier < MessagebirdTexter::Messenger
  default from: 'some string or mobile number'

  def welcome(recipient)
    @recipient = recipient
    
    content(to: recipient.mobile_number, body: 'Some text, reference: recipient.id)
  end
end
```
### Setting defaults

It is possible to set default values that will be used in every method in your MessagebirdTexter Messenger class. To implement this functionality, you just call the public class method default which is inherited from MessagebirdTexter::Messenger. This method accepts a Hash as the parameter. You can use :from, :to and :body as the key.

Note that every value you set with this method will get overwritten if you use the same key in your mailer method.

Example:

```ruby
class TextMessageNotifier < MessagebirdTexter::Messenger
  default from: "Quentin", "00491710000000"
  .....
end
```
### Deliver messages

In order to send your sms, you simply call the method and then call `deliver_now` on the return value.

Calling the method returns a MessagebirdTexter Message object:
```ruby
message = TextMessageNotifier.welcome(User.first)   # => Returns a MessagebirdTexter::Message object
message.deliver_now
```

Installation
------------

If you user bundler, then just add 
```ruby
$ gem 'messagebird-sms'
```
to your Gemfile and execute
```
$ bundle install
```
or without bundler
```
$ gem install messagebird-sms
```

Upgrade
-------
```
$ bundle update messagebird-sms
```
or without bundler

```
$ gem update messagebird-sms
```
​
Changelog
---------

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/HitFox/messagebird-sms. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
