![alt text](http://www.hitfoxgroup.com/downloads/hitfox_logo_with_tag_two_colors_WEB.png "Logo Hitfox Group")


messagebird-texter
=======


Description
-----------

Create ActionMailer-like notifiers to send messages via the Messagebird REST API
 

Usage
------------

### Configure the messenger

Use `MessagebirdTexter.configure` to set `product_token`, `endpoint` and `path`. 

```ruby
MessagebirdTexter.configure do |config|
  config.product_token = 'YOUR_MESSAGEBIRD_API_TOKEN'   
  config.endpoint = 'https://rest.messagebird.com'     
  config.path = '/messages'                             
end
```

### Create a messanger class
Create a class and inherit from `MessagebirdTexter::Messenger`.

```ruby
class TextMessageNotifier < MessagebirdTexter::Messenger
end
```

Now you can add your first welcome message.

```ruby
class TextMessageNotifier < MessagebirdTexter::Messenger
  default from: 'Hitfox'

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

Calling the method returns a `MessagebirdTexter::Message` object:

```ruby
message = TextMessageNotifier.welcome(User.first)   # => Returns a MessagebirdTexter::Message object
response = message.deliver_now
```

### Response Example
Delivering a message returns a `MessagebirdTexter::Response` object. 

####On success

```ruby
=> response.body
=> <MessagebirdTexter::Response::Body:0x007faaca1cfe90
      @content="Some text",
      @created_datetime="2015-12-09T21:43:23+00:00",
      @datacoding="plain",
      @direction="mt",
		 @gateway=10,
		 @href="https://rest.messagebird.com/messages/bd9e796045668a07b0bca95b78482250",
		 @id="bd9e796045668a07b0bca95b78482250",
		 @mclass=1,
		 @originator="me",
		 @recipients=
		  {:totalCount=>1,
		   :totalSentCount=>1,
		   :totalDeliveredCount=>0,
		   :totalDeliveryFailedCount=>0,
		   :items=>
		    [{:recipient=>491759332902, :status=>"sent", :statusDatetime=>"2015-12-09T21:43:23+00:00"}]},
		 @reference=nil,
		 @scheduled_datetime=nil,
		 @type="sms",
		 @validity=nil>

=> response.body.recipients
=> <OpenStruct total_count=1, 
				   total_sent_count=1, 
				   total_delivered_count=0, 
				   items=[
				   		#<OpenStruct recipient=491759332902, 
				   				       status="sent", 
				   						status_datetime=#<Date: 2015-12-09 ((2457366j,0s,0n),+0s,2299161j)>>]>

```

###On failure

```ruby
=> response.error
=> #<MessagebirdTexter::Response::Error:0x007fa3d0c39738
   @errors=[{:code=>25, :description=>"Not enough balance", :parameter=>nil}]>
```





Installation
------------

If you use bundler, then just add 
```ruby
$ gem 'messagebird-texter'
```
to your Gemfile and execute
```
$ bundle install
```
or without bundler
```
$ gem install messagebird-texter
```

Upgrade
-------
```
$ bundle update messagebird-texter
```
or without bundler

```
$ gem update messagebird-texter
```
​
Changelog
---------

###0.0.1 (2015-12-09)
Intilial release

###0.0.2 (2015-12-10)
Minor fixes, readme update

###0.1.0 (2015-12-10)
- Completly remove validators, api handles errors
- readme update

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/HitFox/messagebird-sms. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
