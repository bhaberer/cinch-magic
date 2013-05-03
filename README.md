# Cinch::Plugins::Magic

Just a simple plugin that looks up card info.

## Installation

Add this line to your application's Gemfile:

    gem 'cinch-magic'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cinch-magic

## Usage

Just add the plugin to your list:

    @bot = Cinch::Bot.new do
      configure do |c|
        c.plugins.plugins = [Cinch::Plugins::Magic]
      end
    end

Then in channel use .mtg

    .mtg black lotus

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
