# Local Subdomain

## Description

This gem helps out when your application depends on subdomain support and you don't want to modify you `/etc/hosts` file all the time for your `development` environment.

## Installation

1. Add the gem to your `Gemfile`

```
gem 'local-subdomain'
```

2. Run `bundle install`
3. Include the `LocalSubdomain` module into your `application_controller.rb` (or the controllers that requires subdomain support)

```ruby
class ApplicationController < ActionController::Base
  include LocalSubdomain
  ....
end
```

**NOTE:** Do not force the gem only to be included in the `development` group. Because of the inclusion of the module `LocalSubdomain`, you'll need to have the gem available in every environment.
The gem itself contains guards to only perform changes when the environment is `development`, so no worries.

## What it does

Basically it does two things:

1. Extends the `Rack::Handler` to make sure we bind to `0.0.0.0` instead of `localhost`
2. Adds the `LocalSubdomain` module which executes a `before_filter` to redirect to `http://lvh.me:<port>`

### Rack::Handler

This gem uses the domain [http://lvh.me](http://lvh.me) to handle our requests for our subdomain(s). Request to the domain redirects all to `127.0.0.1`.
This give's us the ability to browse to [http://subsub.lvh.me:3000](http://subsublvh.me:3000) and be handle `request.subdomain` from our controllers.

Because we're going to use the external domain [http://lvh.me](http://lvh.me) which redirects to `127.0.0.1` we have to make our server not to bind to `localhost` only.

### LocalSubdomain module

This module includes a `before_filter` which will check if the request is served by [http://lvh.me](http://lvh.me). If not it will redirect to the domain.

So when we browse to [http://localhost:3000](http://localhost:3000) it will redirect you to [http://lvh.me:3000](http://lvh.me:3000)

## Supported ruby servers

I've tested the gem with:

* [WEBrick](https://rubygems.org/gems/webrick)
* [Puma](http://puma.io/)
* [Thin](http://code.macournoyer.com/thin/)
