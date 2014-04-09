require 'twitter'

module Ladder
  module Twitter
    def notify( challenger, defender )
      Twitter.direct_message_create(defender, "#{challenger} has challenged you!")
      Twitter.direct_message_create(challenger, "You have challenged #{defender}.")
    end

    def post( winner, loser )
      # winner = {:uid => '@rgreget', :rank => 1, :rating => 1200}
      # @rgreget(#1-1200) defeated @bleach(#2-1150)
      Twitter.update("#{winner['uid']}(##{winner['rank']}-#{winner['rating']} defeated #{loser['uid']}(##{loser['rank']}-#{loser['rating']}")
    end
  end
end
