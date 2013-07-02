require 'spec_helper'

describe Cinch::Plugins::Magic do

  include Cinch::Test

  before(:each) do
    @bot = make_bot(Cinch::Plugins::Magic)
  end

  it 'should allow users to lookup cards' do
    get_replies(make_message(@bot, '!mtg forest')).first.
      should include "[Magic] Forest [Basic Land, Forest] - ({T}: Add {G} to your mana pool.)"
  end

  it 'should return an error when a card is not found' do
    get_replies(make_message(@bot, '!mtg random string that is probably not a real card')).first.
      should == '[Magic] Card not found, or problem fetching page.'
  end
end
