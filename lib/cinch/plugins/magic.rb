# -*- coding: utf-8 -*-
require 'cinch'
require 'cinch/toolbox'
require 'cinch/cooldown'

module Cinch
  module Plugins
    # Cinch Plugin to looking MTG cards
    class Magic
      include Cinch::Plugin

      enforce_cooldown

      self.help = 'Use .mtg <card name> to see the info for that card.'

      match(/mtg (.*)/)

      def execute(m, term)
        m.reply get_card(term)
      end

      private

      def get_card(term)
        # Fetch the html for the search term
        data = card_data(term)

        # Catch nil responses.
        return '[Magic] Card not found, or problem fetching page.' if data.nil?

        # Build card string
        card = "#{card_name(data)} [#{card_info(data)}] - #{card_text(data)}"

        # Truncate if it's super long
        card = Cinch::Toolbox.truncate(card, 300)

        "[Magic] #{card} [#{card_link(data)}]"
      end

      def card_info(data)
        text = data[/<p[^>]*>([^<]+)<\/p>/, 1]

        # Replace Newlines, unicode lines, total mana, and large spaces.
        text = text.gsub(/\n/, '')
        text = text.gsub(/\s—/, ', ')
        text = text.gsub(/\s\(\d*\)/, '')
        text = text.gsub(/\s{2,}/, ' ')

        # Remove pesky whitespace that might have snuck in...
        text.strip!

        text
      rescue
        debug 'Error getting the card info'
        return ''
      end

      def card_name(data)
        data[/<a href=[^>]*>([^<]+)<\/a>/, 1]
      rescue
        debug 'Error finding the card name'
        return ''
      end

      def card_link(data)
        "http://magiccards.info#{data[/<a href="([^>]*)">[^<]+<\/a>/, 1]}"
      rescue
        debug 'Error finding the card url'
        return ''
      end

      def card_text(data)
        data[%r{<p class="ctext"><b[^>]*>(.+)</b></p>}, 1].gsub(/<br><br>/, ' ')
      rescue
        debug 'Error finding the card description'
        return ''
      end

      def card_data(term)
        # URI Encode the term and build the URL
        term = URI.escape("!#{term}",
                          Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
        url = "http://magiccards.info/query?q=#{term}"

        # Make sure the URL is legit
        url = URI.extract(url, %w(http https)).first

        # Grab the html block because magiccards.info fucking loves tables
        # and hates helpful ids and classnames
        Cinch::Toolbox.get_html_element(url, '//table[3]/tr/td[2]', :xpath_full)
      rescue
        debug "Error looking up card: #{term}"
        return
      end
    end
  end
end
